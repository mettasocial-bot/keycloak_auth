<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
        <div class=" instruction-container instruction mt-5rem">
		<div class="instruction-card">
			<div style = "text-align: center;">
				<img src="https://cdn.mettasocial.com/logos/imgVerify.png" alt="img" width="40%" />
			</div>
		<div class="verification-instruction">Verification Email Sent</div>
		<div class="verification-p">We have sent a verification email to your inbox, please follow the instructions in the mail and verify your email address.</div>
		
		<p class="verification-note">Note: Please verify your email within 15 mins & check your spam inbox as well</p>
		
		<div class="row btn-section">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 padding-0">
	   			<a class="fw-medium fs-16" href="${url.loginAction}">Resend Verification Email</a>
			</div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 padding-0">
                <button class = "register-btn ${properties.kcButtonClass!} float-right"> <a href="${url.loginUrl}" style="color: #ffffff !important;">Ok</a></button>
            </div>

		</div>
	
	</div>
	</div>
    </#if>
</@layout.registrationLayout>