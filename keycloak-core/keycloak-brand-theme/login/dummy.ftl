<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
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
                    v.src = "https://cdn.mettasocial.com/logos/MS_logo_640x180.svg";
                } else {
                    x.type = "password";
                    v.src = "https://cdn.mettasocial.com/logos/MS_logo_640x180.svg";
                }
            }
        </script>
    <#elseif section = "form">
       
        <div class="box-container">
            <div>
                <p class="application-name">Alfresco Identity Service</p>
            </div>
        <#if realm.password>
            <div>
               <form id="kc-form-login" class="form" onsubmit="return true;" action="${url.loginAction}" method="post">
                    <input id="username" class="login-field" ()"><img id="vi" src="https://cdn.mettasocial.com/logos/MS_logo_640x180.svg";></label>
                    </div>
                <input id="password" class="login-field" placeholder="${msg("password")}" type="password" name="password" tabindex="2">
                <input class="submit" type="submit" value="${msg("doLogIn")}" tabindex="3">
                </form>placeholder="${msg("username")}" type="text" name="username" tabindex="1">
                    <div>
                        <label class="visibility" id="v" onclick="togglePassword
            </div>
        </#if>
        <#if social.providers??>
            <p class="para">${msg("selectAlternative")}</p>
            <div id="social-providers">
                <#list social.providers as p>
                <input class="social-link-style" type="button" onclick="location.href='${p.loginUrl}';" value="${p.displayName}"/>
                </#list>
            </div>
        </#if>
        <div>
            <p class="copyright">&copy; ${msg("copyright", "${.now?string('yyyy')}")}</p>
        </div>
    </#if>
</@layout.registrationLayout>