<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
        <p class="instruction">
            ${msg("emailVerifyInstruction1")}
        </p>
        <h5 class="instruction">
            Please check spam and/or other sections of your mail inbox
        </h5>
        <p class="instruction">
            ${msg("emailVerifyInstruction2")} <a href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
        </p>
    </#if>
</@layout.registrationLayout>