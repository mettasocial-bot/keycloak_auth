<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && social.providers?? && client?? && client.clientId?? && (client.clientId = "local-mettasocial" || client.clientId = "dev-mettasocial-citizen" || client.clientId = "staging-mettasocial-citizen" || client.clientId = "mettasocial-citizen")); section>
    <#if section = "header">
        <link href="https://fonts.googleapis.com/css?family=Muli" rel="stylesheet"/>
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
        <script>
            function togglePassword() {
                var x = document.getElementById("password");
                var v = document.getElementById("vi");
                if (x.type === "password") {
                    console.log("here")
                    x.type = "text";
                    v.src = "https://cdn.mettasocial.com/logos/eye-on.jpg";
                } else {
                    x.type = "password";
                    v.src = "https://cdn.mettasocial.com/logos/eye-off.png";
                }
            }
        </script>
       
    <#if client?? && client.clientId?? && ( client.clientId = "dev-mettasocial-npo"|| client.clientId = "demo-mettasocial-npo"  || client.clientId = "staging-mettasocial-npo" || client.clientId = "mettasocial-npo")>
    <span>NPO</span>
    </#if>

    <#if client?? && client.clientId?? && ( client.clientId = "dev-mettasocial-corp"|| client.clientId = "demo-mettasocial-corp"  || client.clientId = "staging-mettasocial-corp" || client.clientId = "mettasocial-corp")>
    <span>Corporate</span>
    </#if>

        ${msg("doLogIn")}
        <h5 class = "text-center">Enter your details to login to your account</h5>
    <#elseif section = "form">
    <div id="kc-form" <#if realm.password && social.providers?? && client?? && client.clientId?? && (client.clientId = "local-mettasocial" || client.clientId = "dev-mettasocial-citizen" || client.clientId = "staging-mettasocial-citizen" || client.clientId = "mettasocial-citizen")>class="${properties.kcContentWrapperClass!}"</#if>>
      <div id="kc-form-wrapper" <#if realm.password && social.providers?? && client?? && client.clientId?? && (client.clientId = "local-mettasocial" || client.clientId = "dev-mettasocial-citizen" || client.clientId = "staging-mettasocial-citizen" || client.clientId = "mettasocial-citizen")>class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}"</#if>>
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled />
                    <#else>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" placeholder= "user@domain.com" />
                    </#if>
                </div>

                <div class="${properties.kcFormGroupClass!}" style= "position: relative;">
            
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                    <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off" placeholder= "********" />
                    <label class="password-label" id="v" onclick="togglePassword()"><img id="vi" class= "password-image" src="https://cdn.mettasocial.com/logos/eye-off.png"></label>
                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                    <div id="kc-form-options">
                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> Stay Signed In
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> Stay Signed In
                                    </#if>
                                </label>
                            </div>
                        </#if>
                        </div>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>

                  </div>

                  <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} text-center">
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="4" class="${properties.kcButtonClass!} btn-primary ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                  </div>

                   <div class="${properties.kcFormGroupClass!}">
                    <label class="text-center">Connect with thousands of NGOs delivering sustainable impact at scale.</label>
                     </div>

                      <#if realm.password && realm.registrationAllowed  && client?? && client.clientId?? && (client.clientId = "dev-mettasocial-npo" || client.clientId = "staging-mettasocial-npo" || client.clientId = "mettasocial-npo")>
            <div id="kc-registration" class = "align-text-center">
                <span><a tabindex="6" href="${url.registrationUrl}">Join Now</a></span>
            </div>
        </#if>
                                  
            </form>
        </#if>
        </div>
        <#if realm.password && social.providers?? && client?? && client.clientId?? && (client.clientId = "local-mettasocial" || client.clientId = "dev-mettasocial-citizen" || client.clientId = "staging-mettasocial-citizen" || client.clientId = "mettasocial-citizen")>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}">
                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 4>${properties.kcFormSocialAccountDoubleListClass!}</#if>">
                    <#list social.providers as p>
                        <li class="${properties.kcFormSocialAccountListLinkClass!}"><a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.providerId}"> <span>${p.displayName}</span></a></li>
                    </#list>
                </ul>
            </div>
        </#if>
      </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed  && client?? && client.clientId?? && (client.clientId != "dev-mettasocial-npo" && client.clientId != "staging-mettasocial-npo" && client.clientId != "mettasocial-npo" && client.clientId != "android-mettasocial")>
            <div id="kc-registration">
                <span>Join Now <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
