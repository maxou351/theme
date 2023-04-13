<#ftl output_format="XHTML">
<#import "template.ftl" as layout>
<@layout.mainLayout active='account' bodyClass='user'; section>

<div class="row">
    <div class="col-md-10">
        <h2>${msg("editAccountHtmlTitle")}</h2>
    </div>
    <div class="col-md-2 subtitle">
        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
    </div>
</div>

<!-- FranceConnect: Ce formulaire n'est visible uniquement lorsque les données de FranceConnect correspondent avec ceux de MinDefConnect -->
<#if !account.attributes.birthcountry?has_content || account.attributes.birthcountry?matches("[a-zA-Z0-9]{7}")>

    <form action="${url.accountUrl}" class="form-horizontal" method="post">

        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
        
        <#if !realm.registrationEmailAsUsername>
        <div class="form-group ${messagesPerField.printIfExists('username','has-error')}">
            <div class="col-sm-2 col-md-2">
                <label for="username" class="control-label">${msg("username")}</label> <#if realm.editUsernameAllowed><span class="required">*</span></#if>
            </div>

            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="username" name="username" <#if !realm.editUsernameAllowed>disabled="disabled"</#if> value="${(account.username!'')}"/>
            </div>
        </div>
        </#if>

        <div class="form-group ${messagesPerField.printIfExists('email','has-error')}">
            <div class="col-sm-2 col-md-2">
                <label for="email" class="control-label">${msg("email")}</label> <span class="required">*</span>
            </div>

            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="email" name="email" autofocus value="${(account.email!'')}"/>
            </div>
        </div>

        <div class="form-group ${messagesPerField.printIfExists('firstName','has-error')}">
            <div class="col-sm-2 col-md-2">
                <label for="firstName" class="control-label">${msg("firstName")}</label> <span class="required">*</span>
            </div>

            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="firstName" name="firstName" value="${(account.firstName!'')}"/>
            </div>
        </div>

        <div class="form-group ${messagesPerField.printIfExists('lastName','has-error')}">
            <div class="col-sm-2 col-md-2">
                <label for="lastName" class="control-label">${msg("lastName")}</label> <span class="required">*</span>
            </div>

            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="lastName" name="lastName" value="${(account.lastName!'')}"/>
            </div>
        </div>

        <div id="fc-form">
            <!-- gender -->
            <div class="form-group ${messagesPerField.printIfExists('gender','has-error')}">
                <div class="col-sm-2 col-md-2">
                    <label for="user.attributes.gender" class="control-label">${msg("gender")}</label> <span class="required">*</span>
                </div>
                <div class="col-sm-10 col-md-10">
                <#if genders??> 
                    <select class="form-control" id="user.attributes.gender" name="user.attributes.gender" required="required">
                        <#if account.attributes.gender??> 
                            <#list genders as gender>
                                <option value="${gender.name}" ${(account.attributes.gender == gender.name)?then('selected','')}>${gender.description}</option>
                            </#list>
                        <#else>
                            <option value="" disabled="disabled" selected="selected">${msg("input.empty")}</option>
                            <#list genders as gender>
                                <option value="${gender.name}">${gender.description}</option>
                            </#list>
                        </#if>
                    </select>
                <#else>
                    <select class="form-control" id="user.attributes.gender" name="user.attributes.gender" disabled="disabled"></select>
                </#if>
                </div>
            </div>

            <!-- birthdate -->
            <div class="form-group ${messagesPerField.printIfExists('birthDate','has-error')}" id="nativeDatePicker">
                <div id="nativeDatePickerLabel" class="col-sm-2 col-md-2">
                    <label for="birthdate" class="control-label">${msg("birthDate")}</label>
                                <span class="required">*</span>
                </div>
                <div class="col-sm-10 col-md-10">
                    <input 
                        type="date" 
                        class="form-control" 
                        id="birthdate" 
                        name="user.attributes.birthdate" 
                        value="${(birthdate!'')}" 
                        required="required" 
                        placeholder="${msg('input.placeholder.birthdate')}" 
                        pattern="[0-9]{4}.(0[1-9]|1[012]).(0[1-9]|1[0-9]|2[0-9]|3[01])" 
                        title="${msg("birthdate.title")}"/>
                </div>
            </div>

            <div class="form-group ${messagesPerField.printIfExists('birthDate','has-error')}" id="fallbackDatePicker">
                <div class="col-sm-2 col-md-2">
                    <p class="control-label">${msg("birthDate")}</p>
                                <span class="required">*</span>
                </div>
                <div class="col-sm-10">
                    <div class="row">
                        <div class="col-sm-12 col-md-4">
                            <label for="day">${msg("birthDate.day")} :</label>
                            <select id="day" name="day" class="form-control">
                                    <option selected="selected" value="${(day!'')}">${(day!'')}</option>
                            </select>
                        </div>
                        <div class="col-sm-12 col-md-4">
                            <label for="month">${msg("birthDate.month")} :</label>
                            <select id="month" name="month" class="form-control">
                                    <option ${('01' == month!)?then('selected','')} value="01">${msg("birthDate.january")}</option>
                                    <option ${('02' == month!)?then('selected','')} value="02">${msg("birthDate.february")}</option>
                                    <option ${('03' == month!)?then('selected','')} value="03">${msg("birthDate.march")}</option>
                                    <option ${('04' == month!)?then('selected','')} value="04">${msg("birthDate.april")}</option>
                                    <option ${('05' == month!)?then('selected','')} value="05">${msg("birthDate.may")}</option>
                                    <option ${('06' == month!)?then('selected','')} value="06">${msg("birthDate.june")}</option>
                                    <option ${('07' == month!)?then('selected','')} value="07">${msg("birthDate.july")}</option>
                                    <option ${('08' == month!)?then('selected','')} value="08">${msg("birthDate.august")}</option>
                                    <option ${('09' == month!)?then('selected','')} value="09">${msg("birthDate.september")}</option>
                                    <option ${('10' == month!)?then('selected','')} value="10">${msg("birthDate.october")}</option>
                                    <option ${('11' == month!)?then('selected','')} value="11">${msg("birthDate.november")}</option>
                                    <option ${('12' == month!)?then('selected','')} value="12">${msg("birthDate.december")}</option>
                            </select>
                        </div>
                        <div class="col-sm-12 col-md-4">
                            <label for="year">${msg("birthDate.year")} :</label>
                            <select id="year" name="year" class="form-control">
                                    <option selected="selected" value="${(year!'')}">${(year!'')}</option>
                            </select>
                        </div>
                    </div>
                 </div>
            </div>

            <!-- birthcountry -->
            <div class="form-group ${messagesPerField.printIfExists('birthCountry','has-error')}">
                <div class="col-sm-2 col-md-2">
                    <label for="birthcountry" class="control-label">${msg("birthCountry")}</label> <span class="required">*</span>
                </div>
                <div class="col-sm-10 col-md-10">
                <#if countries??> 
                    <select class="form-control" id="birthcountry" name="user.attributes.birthcountry" required="required">
                        <#if account.attributes.birthcountry??>
                            <#list countries as birthcountry>
                               <option value="${birthcountry.inseeCode}" ${(account.attributes.birthcountry == birthcountry.inseeCode)?then('selected','')}>${birthcountry.countryName}</option>
                            </#list>
                        <#else>
                            <option value="" disabled="disabled" selected="selected">${msg("input.empty")}</option>
                            <#list countries as birthcountry>
                               <option value="${birthcountry.inseeCode}">${birthcountry.countryName}</option>
                            </#list>        
                        </#if>     
                    </select>
                <#else>
                    <select class="form-control" id="user.attributes.birthcountry" name="user.attributes.birthcountry" disabled="disabled"></select>
                </#if>
                </div>
            </div>

            <!-- birthplace -->
            <div id="birthPlaceGroup" class="${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('birthPlace',properties.kcFormGroupErrorClass!)}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="birthplace" class="${properties.kcLabelClass!}">${msg("birthPlace")}</label><span class="required">*</span>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="birthplace" name="user.attributes.birthplace" class="${properties.kcInputClass!}" value="${(birthplace)!}" placeholder="${msg("input.placeholder.birthplace")}"
                        title="${msg("birthPlace")}"  required="required" disabled="disabled"/>
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <div id="kc-form-buttons" class="col-md-offset-2 col-md-10 submit">
                <div class="">
                    <#if url.referrerURI??><a href="${url.referrerURI}">${msg("backToApplication")?no_esc}/a></#if>
                    <button type="submit" id="updateAccount" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="submitAction" value="Save">${msg("doSave")}</button>
                    <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="submitAction" value="Cancel">${msg("doCancel")}</button>
                </div>
            </div>
        </div>
    </form>

<#else>
    <div class="row">
        <div class="col-md-12">
            <h3>${msg("accountLinked")}</h3>
        </div>
    </div>
            
    <div class="form-horizontal"> 
            
        <div class="form-group">
            <div class="col-sm-2 col-md-2">
                <label for="email" class="control-label">${msg("email")}</label><span class="required">*</span>
            </div>
            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="email" disabled="disabled" value="${(account.email!'')}"/>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-sm-2 col-md-2">
                <label for="firstName" class="control-label">${msg("firstName")}</label><span class="required">*</span>
            </div>
            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="firstName" disabled="disabled" value="${(account.firstName!'')}"/>
            </div>
        </div>
    
        <div class="form-group">
            <div class="col-sm-2 col-md-2">
                <label for="lastName" class="control-label">${msg("lastName")}</label><span class="required">*</span>
            </div>
            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="lastName"disabled="disabled" value="${(account.lastName!'')}"/>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-sm-2 col-md-2">
                <label for="gender" class="control-label">${msg("gender")}</label><span class="required">*</span>
            </div>
            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="gender" disabled="disabled" value="${(account.attributes.gender!'')}"/>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-sm-2 col-md-2">
                <label for="birthDate" class="control-label">${msg("birthDate")}</label><span class="required">*</span>
            </div>
            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="birthDate" disabled="disabled" value="${(account.attributes.birthdate!'')}"/>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-sm-2 col-md-2">
                <label for="birthCountry" class="control-label">${msg("birthCountry")}</label><span class="required">*</span>
            </div>
            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="birthCountry" disabled="disabled" value="${(account.attributes.birthcountry!'')}"/>
                <span class="spanInfo">${msg("inseeCode")}</span>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-sm-2 col-md-2">
                <label for="birthPlace" class="control-label">${msg("birthPlace")}</label><span class="required">*</span>
            </div>
            <div class="col-sm-10 col-md-10">
                <input type="text" class="form-control" id="birthPlace" disabled="disabled" value="${(account.attributes.birthplace!'')}"/>
                <span class="spanInfo">${msg("inseeCode")}</span>
            </div>
        </div>
    
    </div>

    <div>
        <a href="https://franceconnect.gouv.fr/">${msg("franceconnect.whatis")}</a>
    </div>
        
</#if>

</@layout.mainLayout>