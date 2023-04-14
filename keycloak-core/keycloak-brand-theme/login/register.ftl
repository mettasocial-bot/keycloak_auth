<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        Sign Up
    <#elseif section = "form">
    <script>
        let countryList = []
window.addEventListener('load', () => {
    fetch('https://restcountries.com/v3.1/all')
        .then(response => response.json())
        .then(data => {
            countryList = data;
            var selectOptions = '';
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
        </script>
    <form id="kc-register-form" class="${properties.kcFormClass!}"  action="${url.registrationAction}" method="post">

         
            <#if client?? && client.clientId?? && client.clientId = "mettasocial-npo">
              
             <div class="form-group ${properties.kcContentWrapperClass!}">
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.ngoName" class="${properties.kcLabelClass!}">NGO Name</label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="text" required  required class="${properties.kcInputClass!}" id="user.attributes.ngoName" name="user.attributes.ngoName" value="${(register.formData['user.attributes.ngoName']!'')}"/>
               </div>
            </div>
             
        </#if>


        



            <div class = "form-group ${properties.kcContentWrapperClass!}">

                <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName" value="${(register.formData.firstName!'')}" />
                        </div>
                    </div>
                </div>
                <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('lastName',properties.kcFormGroupErrorClass!)}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName" value="${(register.formData.lastName!'')}" />
                        </div>
                    </div>
                </div>
            </div>

        <#if client?? && client.clientId?? && client.clientId = "mettasocial-npo">

            <div class = "form-group ${properties.kcContentWrapperClass!}">

                <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('firstName',properties.kcFormGroupErrorClass!)}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="registrationType" class="${properties.kcLabelClass!}">Registration Type</label>
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
                   <label for="user.attributes.registrationDate" class="${properties.kcLabelClass!}">Registration Date</label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="date" required  required class="${properties.kcInputClass!}" id="user.attributes.registrationDate" name="user.attributes.registrationDate" value="${(register.formData['user.attributes.registrationDate']!'')}"/>
               </div>
                    </div>
                </div>
            </div>

</#if>
                <#if client?? && client.clientId?? && client.clientId = "mettasocial-npo">
              
             <div class="form-group ${properties.kcContentWrapperClass!}">
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.registrationNumber" class="${properties.kcLabelClass!}">Registration Number</label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="text" required  required class="${properties.kcInputClass!}" id="user.attributes.registrationNumber" name="user.attributes.registrationNumber" value="${(register.formData['user.attributes.registrationNumber']!'')}"/>
               </div>
            </div>
             
        </#if>


            <div class="form-group ${properties.kcContentWrapperClass!}">
               <div class="${properties.kcLabelWrapperClass!}">
                   <label for="user.attributes.contactNumber" class="${properties.kcLabelClass!}">Contact Number</label>
               </div>
               <div class="${properties.kcInputWrapperClass!}">
                   <input type="tel" required pattern="[0-9]{10}" required class="${properties.kcInputClass!}" id="user.attributes.contactNumber" name="user.attributes.contactNumber" value="${(register.formData['user.attributes.contactNumber']!'')}"/>
               </div>
            </div>

            <div class="${properties.kcFormGroupClass!} ${properties.kcContentWrapperClass!} ${messagesPerField.printIfExists('email',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="email" class="${properties.kcLabelClass!}">Email Address</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="email" class="${properties.kcInputClass!}" name="email" value="${(register.formData.email!'')}" autocomplete="email" />
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
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password" class="${properties.kcInputClass!}" name="password" autocomplete="new-password"/>
                        </div>
                  
                </div>
               
            </div>        
            <div class = "form-group ${properties.kcContentWrapperClass!}">

             
                    <div class=" ${messagesPerField.printIfExists('password-confirm',properties.kcFormGroupErrorClass!)}">
                            <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                            </div>
                        <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-confirm" class="${properties.kcInputClass!}" name="password-confirm" />
                        </div>
                    </div>
               
               
            </div>        
            </#if>

               <#if client?? && client.clientId?? && client.clientId = "mettasocial-npo">
              
             <div class = "form-group ${properties.kcContentWrapperClass!}">

                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="country" class="${properties.kcLabelClass!}">Country</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">

                            <select class="${properties.kcInputClass!}" id="user.attributes.country" name="user.attributes.country" onchange="populateDropdowns()" value="${(register.formData['user.attributes.country']!'')}">
                                <option > Please Select </option>
                         
                        
                            </select>
                      </div>
                    </div>
                </div>
                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="language" class="${properties.kcLabelClass!}">Language</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">

                         <select class="${properties.kcInputClass!}" id="user.attributes.language" name="user.attributes.language" value="${(register.formData['user.attributes.language']!'')}">
                            <option > Please Select </option>
                         
                        
                   </select>
                      </div>
                    </div>
                </div>
            </div>
             
        </#if>




     <#if client?? && client.clientId?? && client.clientId = "mettasocial-npo">
              
             <div class = "form-group ${properties.kcContentWrapperClass!}">

                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="currency" class="${properties.kcLabelClass!}">Currency</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">

                            <select class="${properties.kcInputClass!}" id="user.attributes.currency" name="user.attributes.currency" value="${(register.formData['user.attributes.currency']!'')}">
                                <option > Please Select </option>
                         
                        
                            </select>
                      </div>
                    </div>
                </div>
                 <div class= "col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                    <label for="timezone" class="${properties.kcLabelClass!}">Timezone</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                         <select class="${properties.kcInputClass!}" id="user.attributes.timezone" name="user.attributes.timezone" value="${(register.formData['user.attributes.language']!'')}">
                            <option > Please Select </option>
                         
                        
                   </select>
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
             
             <input  type="checkbox" name="tnc_accepted" required="" id="tnc_agreed"  value="true" checked=""><label class="col-11 left-margin" for="tnc_agreed">Agree to <a href="https://www.mettasocial.com/terms-and-conditions" class="color-1FA4FA text-underline cursor-pointer" rel="noreferrer noopener" target="_blank">Terms &amp; Conditions</a><span class="color-FF2300">*</span></label></div>
            </div>

            <div class="btn-section ${properties.kcFormGroupClass!} ${properties.kcContentWrapperClass!}">
                <div id="" class="left-margin">
                    <input class="cancel-btn ${properties.kcButtonClass!}" type="submit" value="Cancel"/>
                </div>             

                <div id="" class="left-margin">
                    <input class="register-btn ${properties.kcButtonClass!}" type="submit" value="Next"/>
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