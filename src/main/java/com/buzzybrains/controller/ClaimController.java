package com.buzzybrains.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
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
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.buzzybrains.dao.ClaimItemsRepo;
import com.buzzybrains.dao.ClaimRepo;
import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.Claim;
import com.buzzybrains.model.ClaimItems;


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

	public String submitClaim(@ModelAttribute Claim claim, BindingResult bindingResult,
			@RequestParam("upload_file") MultipartFile[] files, HttpServletRequest request) {
		claimRepo.save(claim);
		int claimId = claim.getClaimId();
		List<ClaimItems> claimList = claim.getClaimItems();
		MultipartFile[] fileList = files;

		for (int i = 0; i < fileList.length; i++) {
			ClaimItems ci = claimList.get(i);
			ci.setClaimItemFile(fileList[i].getOriginalFilename());
			ci.setClaimId(claimId);
			claimItemsRepo.save(ci);
			addtoS3storage(fileList[i], claimId);
		}
		request.setAttribute("mode", "MODE_NEW");
		return "claim";
	}

	public void addtoS3storage(MultipartFile multpartfile, int claimId) {
		AWSCredentials credentials = new BasicAWSCredentials("<>",
				"<>");
		AmazonS3 s3client = new AmazonS3Client(credentials);
		String bucketName = null;
		for (Bucket bucket : s3client.listBuckets()) {
			bucketName = bucket.getName(); // get bucket name
		}
		File convFile;
		String file_name = multpartfile.getOriginalFilename();
		convFile = new File(file_name);
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
		String folderName = "" + claimId;
		createFolder(bucketName, folderName, s3client);

		String fileName = folderName + SUFFIX + file_name;

		s3client.putObject(
				new PutObjectRequest(bucketName, fileName, convFile).withCannedAcl(CannedAccessControlList.PublicRead));

	}
	
	@GetMapping("/file-list")
	@ResponseBody
	public List<ClaimItems> fileList(int claimid) {
		return claimItemsRepo.findItemListByClaimId(claimid);
	}

	@GetMapping("/file-attachment")
	@ResponseBody
	public void getFileAttachment(HttpServletResponse response, Integer claimid, String file_name,
			HttpServletRequest request) {
		
		AWSCredentials credentials = new BasicAWSCredentials("AKIAI7VDFZTLEOFLBXXA",
				"2/TWPnvRe2Gs3jZ/NmoM5lzdXNoAKUqOKTuXDViM");
		AmazonS3 s3client = new AmazonS3Client(credentials);
		
		String key = claimid + "/" + file_name;
		//System.out.println(key);

		S3Object fileObject = s3client.getObject(new GetObjectRequest("buzzybrains", key));
		InputStream in = fileObject.getObjectContent();
		try {
			response.setHeader("Expires", "0");
			response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
			response.setHeader("Pragma", "public");
			response.setContentType("application/*");
			response.setHeader("Content-disposition", "attachment; filename=" + file_name);
			IOUtils.copy(in, response.getOutputStream());
		    response.getOutputStream().flush();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
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
