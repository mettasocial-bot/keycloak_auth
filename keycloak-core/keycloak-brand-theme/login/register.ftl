<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        Sign Up
    <#elseif section = "form">
    <script>
        let countryList = []
window.addEventListener('load', () => {
    var today = new Date().toISOString().split('T')[0];
    document.getElementsByName("user.attributes.registrationDate")[0].setAttribute('max', today);
    fetch('https://restcountries.com/v3.1/all')
        .then(response => response.json())
        .then(data => {
            var selectOptions = '';
            countryList = data;
            let countryArray = [];
            let objIndex = data.findIndex(x=> x.name.common === "India") 
            if(objIndex > -1){
              selectOptions +=  '<option value="' + data[objIndex].name.common + '">' + data[objIndex].name.common + '</option>';
              data.splice(objIndex, 1)
            }
             data.sort((a, b) => {
                  if (a.name.common < b.name.common) {
                   return -1;
                      }
                  if (a.name.common > b.name.common) {
                  return 1;
                      }
                     return 0;
                    });
          
            for (var i = 0; i < data.length; i++) {

                selectOptions += '<option value="' + data[i].name.common + '">' + data[i].name.common + '</option>';
            }
            document.getElementById('user.attributes.country').innerHTML = selectOptions;
        })
        .catch(error => {
            console.error(error);
        });
});


function populateDropdowns() {

    var selectedValue = document.getElementById("user.attributes.country").value;

    // Clear the other dropdowns

    let country = countryList.find(x => x.name.common == selectedValue)

    if (country) {
        console.log(country)
        let currencies = ""
        let languages = ""
        let timezones = ""
        for (let key in country.currencies) {
            console.log(key)
            currencies += '<option value="' + key + '">' + key + '</option>';
        }

        for (let key in country.languages) {
            console.log(country.languages[key])
            languages += '<option value="' + country.languages[key] + '">' + country.languages[key] + '</option>';
        }

        for (let i = 0; i < country.timezones.length; i++) {
            console.log(country.timezones[i])
            timezones += '<option value="' + country.timezones[i] + '">' + country.timezones[i] + '</option>';
        }

        document.getElementById('user.attributes.language').innerHTML = languages;
        document.getElementById('user.attributes.currency').innerHTML = currencies;
        document.getElementById('user.attributes.timezone').innerHTML = timezones;
    }
}
function validatePassword() {
     var x = document.getElementById("password-confirm");
     x.disabled = false;
}

function cancelRegistration(){
     console.log("cancel Clicked");
    window.open("https://mettasocial.com", "_blank");
}

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

function toggleConfirmPassword() {
                var x = document.getElementById("password-confirm");
                var v = document.getElementById("confirmpasswordimg");
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
    <form id="kc-register-form" class="${properties.kcFormClass!}"  action="${url.registrationAction}" method="post">

         
            <#if client?? && client.clientId?? && (client.clientId = "dev-mettasocial-npo" ||
            client.clientId = "staging-mettasocial-npo" ||
            client.clientId = "demo-mettasocial-npo" ||
            client.clientId = "mettasocial-npo")>
              
             <div class="form-group ${properties.kcContentWrapperClass!}">
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.ngoName" class="${properties.kcLabelClass!}">NGO Name <span class="color-FF2300">*</span></label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="text" required  required class="${properties.kcInputClass!}" id="user.attributes.ngoName" name="user.attributes.ngoName" maxlength="100"  value="${(register.formData['user.attributes.ngoName']!'')}"/>
               </div>
            </div>
             
        </#if>


        



            <div class = "form-group ${properties.kcContentWrapperClass!}">

                <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="firstName" class="${properties.kcLabelClass!}">First Name <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName" maxlength="50" value="${(register.formData.firstName!'')}" />
                        </div>
                    </div>
                </div>
                <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="lastName" class="${properties.kcLabelClass!}">Last Name <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName" maxlength="50" value="${(register.formData.lastName!'')}" />
                        </div>
                    </div>
                </div>
            </div>

        <#if client?? && client.clientId?? && (client.clientId = "dev-mettasocial-npo" ||
            client.clientId = "staging-mettasocial-npo" ||
            client.clientId = "demo-mettasocial-npo" ||
            client.clientId = "mettasocial-npo")>

            <div class = "form-group ${properties.kcContentWrapperClass!}">

                <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6" style="padding-right: 1rem;">
                    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="registrationType" class="${properties.kcLabelClass!}">Registration Type <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">

                         <select class="${properties.kcInputClass!}" id="user.attributes.registrationType" name="user.attributes.registrationType" value="${(register.formData['user.attributes.registrationType']!'')}">
                            <option > Please Select </option>
                            <option value="1">Society Registration</option>
                            <option value="2">Trust Registration</option>
                            <option value="3">Company Registration</option>
                        
                   </select>
                      </div>
                    </div>
                </div>
                <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                           <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.registrationDate" class="${properties.kcLabelClass!}">Registration Date <span class="color-FF2300">*</span></label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="date" required class="${properties.kcInputClass!}" id="user.attributes.registrationDate" name="user.attributes.registrationDate"   value="${(register.formData['user.attributes.registrationDate']!'')}"/>
               </div>
                    </div>
                </div>
            </div>

</#if>
                <#if client?? && client.clientId?? && (client.clientId = "dev-mettasocial-npo" ||
            client.clientId = "staging-mettasocial-npo" ||
            client.clientId = "demo-mettasocial-npo" ||
            client.clientId = "mettasocial-npo")>
              
             <div class="form-group ${properties.kcContentWrapperClass!}">
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.registrationNumber" class="${properties.kcLabelClass!}">Registration Number <span class="color-FF2300">*</span></label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="text" required  required class="${properties.kcInputClass!}" id="user.attributes.registrationNumber" name="user.attributes.registrationNumber" value="${(register.formData['user.attributes.registrationNumber']!'')}"/>
               </div>
            </div>
             
        </#if>


            <div class="form-group ${properties.kcContentWrapperClass!}">
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.contactNumber" class="${properties.kcLabelClass!}">Contact Number <span class="color-FF2300">*</span></label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="tel"  pattern="[0-9]{10}" required class="${properties.kcInputClass!}" placeholder = "9876543210" placeholder= "user@domain.com" id="user.attributes.contactNumber" maxlength="10" name="user.attributes.contactNumber" value="${(register.formData['user.attributes.contactNumber']!'')}"/>
               </div>
            </div>

            <div class="${properties.kcFormGroupClass!} ${properties.kcContentWrapperClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="email" class="${properties.kcLabelClass!}">Email Address <span class="color-FF2300">*</span></label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="email" class="${properties.kcInputClass!}" name="email" placeholder= "user@domain.com" maxlength="50" value="${(register.formData.email!'')}" autocomplete="email" />
                </div>
            </div>

          <#if !realm.registrationEmailAsUsername>
            <div class="${properties.kcFormGroupClass!}  ${properties.kcContentWrapperClass!} ${messagesPerField.printIfExists('username',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="username" class="${properties.kcInputClass!}" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
                </div>
            </div>
          </#if>

            <#if passwordRequired??>

            <div class = "form-group ${properties.kcContentWrapperClass!}">

                    <div class="  ${messagesPerField.printIfExists('password',properties.kcFormGroupErrorClass!)}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}  <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password" class="${properties.kcInputClass!}" name="password" onchange= "validatePassword()" autocomplete="new-password"/>
                        <label class="password-label" id="v" onclick="togglePassword()" style="
    right: 28px;
"><img id="vi" class= "password-image" src="https://cdn.mettasocial.com/logos/eye-off.png"></label>

                        </div>
                  
                </div>
               
            </div>        
            <div class = "form-group ${properties.kcContentWrapperClass!}">

             
                    <div class=" ${messagesPerField.printIfExists('password-confirm',properties.kcFormGroupErrorClass!)}">
                            <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">Confirm Password  <span class="color-FF2300">*</span></label>
                            </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-confirm" class="${properties.kcInputClass!}" disabled placeholder = "******" name="password-confirm" />
                        <label class="password-label" id="v" onclick="toggleConfirmPassword()" style="
    right: 28px;
"><img id="confirmpasswordimg" class= "password-image" src="https://cdn.mettasocial.com/logos/eye-off.png"></label>

                        </div>
                    </div>
               
               
            </div>        
            </#if>

               <#if client?? && client.clientId?? && (client.clientId = "dev-mettasocial-npo" ||
            client.clientId = "staging-mettasocial-npo" ||
            client.clientId = "demo-mettasocial-npo" ||
            client.clientId = "mettasocial-npo")>
              
             <div class = "form-group ${properties.kcContentWrapperClass!}">

                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="country" class="${properties.kcLabelClass!}">Country  <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">

                            <select class="${properties.kcInputClass!}" id="user.attributes.country" name="user.attributes.country" disabled onchange="populateDropdowns()" value="${(register.formData['user.attributes.country']!'')}">
                                <option > India </option>
                         
                        
                            </select>
                            <input type="hidden" name="user.attributes.country" id="user.attributes.country" value = "India">
                      </div>
                    </div>
                </div>
                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="language" class="${properties.kcLabelClass!}">Language  <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">

                         <select class="${properties.kcInputClass!}" id="user.attributes.language" name="user.attributes.language" disabled value="${(register.formData['user.attributes.language']!'')}">
                            <option > English </option>
                             
                   </select>
                    <input type="hidden" name="user.attributes.language" id="user.attributes.language" value = "English">
                        
                      </div>
                    </div>
                </div>
            </div>
             
        </#if>




     <#if client?? && client.clientId?? && (client.clientId = "dev-mettasocial-npo" ||
            client.clientId = "staging-mettasocial-npo" ||
            client.clientId = "demo-mettasocial-npo" ||
            client.clientId = "mettasocial-npo")>
              
             <div class = "form-group ${properties.kcContentWrapperClass!}">

                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="currency" class="${properties.kcLabelClass!}">Currency  <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">

                            <select class="${properties.kcInputClass!}" id="user.attributes.currency" name="user.attributes.currency" disabled value="${(register.formData['user.attributes.currency']!'')}">
                                <option > INR </option>
                         
                        
                            </select>
                             <input type="hidden" name="user.attributes.currency" id="user.attributes.currency" value = "INR">
                        
                      </div>
                    </div>
                </div>
                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="timezone" class="${properties.kcLabelClass!}">Timezone  <span class="color-FF2300">*</span></label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                         <select class="${properties.kcInputClass!}" id="user.attributes.timezone" name="user.attributes.timezone"  disabled value="${(register.formData['user.attributes.language']!'')}">
                            <option >UTC+05:30</option>
                   </select>
                      <input type="hidden" name="user.attributes.timezone" id="user.attributes.currtimezoneency" value = "UTC+05:30">
                      </div>
                    </div>
                </div>
            </div>
             
        </#if>
           
            <div <#if client?? && client.clientId?? && client.clientId = "local-mettasocial">class="form-group"<#else>class="form-group hidden-xs hidden-sm hidden-md hidden-lg"</#if>>
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.type" class="${properties.kcLabelClass!}">I am a</label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <select class="${properties.kcInputClass!}" id="user.attributes.type" name="user.attributes.type" value="${(register.formData['user.attributes.type']!'')}">
                        <#if client?? && client.clientId?? && client.clientId = "local-mettasocial">
                            <option value="2">NGO</option>
                            <option value="4">Corporate</option>
                            <option value="8">Citizen</option>
                        <#elseif client?? && client.clientId?? && (client.clientId = "dev-mettasocial-npo" || client.clientId = "staging-mettasocial-npo" || client.clientId = "mettasocial-npo")>
                            <option value="2" selected>NGO</option>
                        <#elseif client?? && client.clientId?? && (client.clientId = "dev-mettasocial-corp" || client.clientId = "staging-mettasocial-corp" || client.clientId = "mettasocial-corp")>
                            <option value="4" selected>Corporate</option>
                        <#elseif client?? && client.clientId?? && (client.clientId = "dev-mettasocial-citizen" || client.clientId = "staging-mettasocial-citizen" || client.clientId = "mettasocial-citizen" || client.clientId = "android-mettasocial")>
                            <option value="8" selected>Citizen</option>
                        </#if>
                   </select>
               </div>
            </div>


            <#if recaptchaRequired??>
            <div class="form-group">
                <div class="${properties.kcInputWrapperClass!}">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
            </div>
            </#if>

             <div class = "form-group left-margin ${properties.kcContentWrapperClass!}">
             
             <input  type="checkbox" name="tnc_accepted" required id="tnc_agreed"  value="true" ><label class="col-11 left-margin" for="tnc_agreed">Agree to <a href="https://www.mettasocial.com/terms-and-conditions" class="color-1FA4FA text-underline cursor-pointer" rel="noreferrer noopener" target="_blank">Terms of Service</a> and <a href="https://www.mettasocial.com/privacy-policy" class="color-1FA4FA text-underline cursor-pointer" rel="noreferrer noopener" target="_blank"> Privacy Policy</a><span class="color-FF2300">*</span></label></div>
            </div>

            <div class="btn-section ${properties.kcFormGroupClass!} ${properties.kcContentWrapperClass!}">
                <div id="" class= "col-xs-6 col-sm-6 col-md-6 col-lg-6 padding-0">
                    <input class="cancel-btn ${properties.kcButtonClass!}" type="cancel" value="Cancel" onclick = "cancelRegistration()"/>
                </div>             

                <div id="" class= "col-xs-6 col-sm-6 col-md-6 col-lg-6 padding-0">
                    <input class="register-btn ${properties.kcButtonClass!}" type="submit" value="Verify Email"/>
                </div>
            </div>

            <div>
               <div id="kc-form-options">
                    <div class="align-text-center">
                        <span> Already have an account? <a href="${url.loginUrl}">Login</a></span>
                    </div>
                </div>
            </div>
        </form>  
    </#if>
</@layout.registrationLayout>