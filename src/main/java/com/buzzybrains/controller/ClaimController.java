package com.buzzybrains.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3ObjectSummary;
import com.buzzybrains.dao.ClaimItemsRepo;
import com.buzzybrains.dao.ClaimRepo;
import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.Claim;
import com.buzzybrains.model.ClaimItems;
import com.buzzybrains.model.UserProfile;
import com.buzzybrains.util.PDFDownload;

@Controller
public class ClaimController {
	private static final String SUFFIX = "/";

	@Autowired
	ClaimRepo claimRepo;

	@Autowired
	ClaimItemsRepo claimItemsRepo;

	@Autowired
	UserProfileRepo userProfileRepo;

	@GetMapping("/claim-form")
	public String showClaimForm(HttpServletRequest request) {

		request.setAttribute("mode", "MODE_NEW");
		return "claim";
	}

	@GetMapping("/claim-list")
	public String getClaimList(HttpServletRequest request, int userid) {
		List<Claim> claimList = claimRepo.findClaimListByuserId(userid);
		request.setAttribute("claimList", claimList);
		request.setAttribute("mode", "MODE_HISTORY");
		return "claim";
	}

	@PostMapping("/create-claim")
	public String submitClaim(@ModelAttribute Claim claim, BindingResult bindingResult,@RequestParam("upload_file") MultipartFile[] files,HttpServletRequest request) {
		//System.out.println("********************Claim End Date:"+claim.getEnd());
		
		claimRepo.save(claim);
		int claimId = claim.getClaimId();
		List<ClaimItems> claimList = claim.getClaimItems();
		MultipartFile[] fileList = files;
		
		for(int i=0;i<fileList.length;i++){
			ClaimItems ci=claimList.get(i);
			ci.setClaimItemFile(fileList[i].getOriginalFilename());
			ci.setClaimId(claimId);
			claimItemsRepo.save(ci);
			addtoS3storage(fileList[i],claimId);
		}
		request.setAttribute("mode", "MODE_NEW");
		return "claim";
	}

	public void addtoS3storage(MultipartFile multpartfile, int claimId) {
		AWSCredentials credentials = new BasicAWSCredentials("AKIAI7VDFZTLEOFLBXXA",
				"2/TWPnvRe2Gs3jZ/NmoM5lzdXNoAKUqOKTuXDViM");
		AmazonS3 s3client = new AmazonS3Client(credentials);
		String bucketName = null;
		for (Bucket bucket : s3client.listBuckets()) {
			bucketName = bucket.getName(); // get bucket name
		}
		File convFile;
		String file_name=multpartfile.getOriginalFilename();
		convFile=new File(file_name);
		try {
			convFile.createNewFile();
			FileOutputStream fos = new FileOutputStream(convFile);
			fos.write(multpartfile.getBytes());
			fos.close();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
		String folderName =""+claimId;
		createFolder(bucketName, folderName, s3client);

		String fileName = folderName + SUFFIX + file_name;

		s3client.putObject(
				new PutObjectRequest(bucketName, fileName, convFile).withCannedAcl(CannedAccessControlList.PublicRead));

	}

	@GetMapping("/claim-download")
	@ResponseBody
	public void generateClaimPdf(HttpServletResponse response, int claimid) {

		Claim claim = claimRepo.findOne(claimid);
		int userid = claim.getUserId();
		UserProfile userProfile = userProfileRepo.findByUserId(userid);
		claim.setClaimItems(claimItemsRepo.findItemListByClaimId(claimid));
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-YYYY");
		String fileName = sdf.format(claim.getStart()) + "__" + sdf.format(claim.getEnd()) + ".pdf";

		try {
			PDFDownload pdfDownload = new PDFDownload(claim, userProfile);

			ByteArrayOutputStream baos = pdfDownload.generatePDF();
			response.setHeader("Expires", "0");
			response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
			response.setHeader("Pragma", "public");
			response.setContentType("application/pdf");
			response.setContentLength(baos.size());
			response.setHeader("Content-disposition", "attachment; filename=" + fileName);
			ServletOutputStream out = response.getOutputStream();

			baos.writeTo(out);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	@GetMapping("/claim-attachment")
	
	public String getClaimAttachment(HttpServletResponse response, int claimid, HttpServletRequest request) {
		//System.out.println("Claim Id:"+claimid);
		
		List<String> fileList=claimItemsRepo.getFileListForClaim(claimid);
		
		AWSCredentials credentials = new BasicAWSCredentials("AKIAI7VDFZTLEOFLBXXA",
				"2/TWPnvRe2Gs3jZ/NmoM5lzdXNoAKUqOKTuXDViM");
		AmazonS3 s3client = new AmazonS3Client(credentials);
		String bucketName = null;
		for (Bucket bucket : s3client.listBuckets()) {
			bucketName = bucket.getName(); // get bucket name
		}
		ObjectListing objects = s3client.listObjects(bucketName);
		do {
		        for (S3ObjectSummary objectSummary : objects.getObjectSummaries()) {
		             for(String filename:fileList){
		                if(objectSummary.getKey().equals(claimid+"/"+filename)){
		                	String key=objectSummary.getKey();
		                	s3client.getObject(
		            		        new GetObjectRequest(bucketName,key),
		            		        new File("C:/Users/Admin/Downloads/"+key)
		            		);
		                }
		                }
		        }
		        objects = s3client.listNextBatchOfObjects(objects);
		} while (objects.isTruncated());
		
		//To display claim history page again
		Claim claim=claimRepo.findOne(claimid);
		int userid=claim.getUserId();
		List<Claim> claimList = claimRepo.findClaimListByuserId(userid);
		request.setAttribute("claimList", claimList);
		request.setAttribute("mode", "MODE_HISTORY");
		return "claim";

	}

	private void createFolder(String bucketName, String folderName, AmazonS3 client) {
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentLength(0);
		InputStream emptyContent = new ByteArrayInputStream(new byte[0]);
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, folderName + SUFFIX, emptyContent,
				metadata);
		client.putObject(putObjectRequest);

	}

}
