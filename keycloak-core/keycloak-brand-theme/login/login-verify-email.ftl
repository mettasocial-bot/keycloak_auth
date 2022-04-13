<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
   <h5 class="instruction">
   We sent an email to you with a link to activate a new Metta Social account.</h5>
   <p class="instruction">If you don’t see an email from us within a few minutes, a few things could have happened:</p>
    <p class="instruction">The email is in your spam folder.</p>
    <p class="instruction">The email address you entered had a mistake or typo.</p>
    <p class="instruction">You accidentally gave us the wrong email address.</p>
    <p class="instruction">We can’t deliver the email to this address (usually due to corporate firewalls or filtering.)</p>
    <p class="instruction">
             <a href="${url.loginAction}">${msg("doClickHere")}</a>  to Re-enter your email and try again
     </p>
    </#if>
</@layout.registrationLayout>