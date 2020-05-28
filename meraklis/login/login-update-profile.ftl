<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <form id="kc-update-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <#if user.editUsernameAllowed>
                <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="username" name="username" value="${(user.username!'')}" class="${properties.kcInputClass!}"/>
                    </div>
                </div>
            </#if>
            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="email" name="email" value="${(user.email!'')}" class="${properties.kcInputClass!}" />
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="firstName" name="firstName" value="${(user.firstName!'')}" class="${properties.kcInputClass!}" />
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="lastName" name="lastName" value="${(user.lastName!'')}" class="${properties.kcInputClass!}" />
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.contactNumber" class="${properties.kcLabelClass!}">Contact Number</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.contactNumber" name="user.attributes.contactNumber" value="${(user.attributes.contactNumber!'')}" class="${properties.kcInputClass!}" />
                </div>
            </div>

            <#if client?? && client.clientId?? && client.clientId = "local-meraklis">
                <div class="form-group">
            <#else>
                <div class="form-group hidden-xs hidden-sm hidden-md hidden-lg">
            </#if>
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.type" class="${properties.kcLabelClass!}">I am a</label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                    <select type="text" class="${properties.kcInputClass!}" id="user.attributes.type" name="user.attributes.type" value="${(user.attributes.type!'')}">
                        <#if client?? && client.clientId?? && client.clientId = "local-meraklis">
                            <option value="2">NGO</option>
                            <option value="4">Corporate</option>
                            <option value="8">Citizen</option>
                        <#elseif client?? && client.clientId?? && (client.clientId = "dev-meraklis-npo" || client.clientId = "staging-meraklis-npo" || client.clientId = "meraklis-npo")>
                            <option value="2" selected>NGO</option>
                        <#elseif client?? && client.clientId?? && (client.clientId = "dev-meraklis-corp" || client.clientId = "staging-meraklis-corp" || client.clientId = "meraklis-corp")>
                            <option value="4" selected>Corporate</option>
                        <#elseif client?? && client.clientId?? && (client.clientId = "dev-meraklis-citizen" || client.clientId = "staging-meraklis-citizen" || client.clientId = "meraklis-citizen" || client.clientId = "android-meraklis")>
                            <option value="8" selected>Citizen</option>
                        </#if>
                   </select>
                   <span>Please note that, <b>We are currently supporting only NGO & Corporate registrations.</b></span>
               </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <#if isAppInitiatedAction??>
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                    <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                    <#else>
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                    </#if>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
