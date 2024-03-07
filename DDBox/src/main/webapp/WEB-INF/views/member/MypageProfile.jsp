<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 내용 시작 -->
<div class="page-main">
<h2>마이페이지 프로필관리</h2>
<ul class="photo-upload-container">
    <li class="photo-display">
        <img src="${pageContext.request.contextPath}/member/photoView" alt="My Photo" class="my-photo">
        <label for="upload" class="camera-icon" id="photo_btn">
            <img src="${pageContext.request.contextPath}/images/insta1.jpg" alt="Change Photo" width="35">
        </label>
    </li>
    <li class="photo-options" style="display: none;" id="photo_choice">
        <input type="file" id="upload" accept="image/gif, image/png, image/jpeg" style="display: none;">
        <button id="photo_submit" class="btn photo-btn">Upload</button>
        <button id="photo_reset" class="btn photo-btn">Cancel</button>
    </li>
</ul>
	
	<div>
		※개인정보가 포함된 이미지 등록은 자제하여 주시기 바랍니다.
	</div>
	
	
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.profile.js"></script>
<!-- 내용 끝 -->