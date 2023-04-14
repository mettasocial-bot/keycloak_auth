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
		<div class="verification-email-h">We have sent an email to:</div>

  <p class="verification-email">${user.getEmail()}</p>

		<p class="verification-email">email@example.com</p>
		<p class="verification-note">Note: Please verify your email within 15 mins & check your spam inbox as well</p>
		
		<div class="mt-5rem">
			<div class="float-left">
	   			<a class="fw-medium fs-16" href="${url.loginAction}">Resend Verification Email</a>
			</div>
			
		</div>
	
	</div>
	</div>
    </#if>
</@layout.registrationLayout>