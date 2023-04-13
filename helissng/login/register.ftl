<#ftl output_format="XHTML">
<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("registerWithTitle",(realm.displayName!''))}
    <#elseif section = "header">
        ${msg("registerWithTitleHtml",(realm.displayNameHtml!''))?no_esc}
    <#elseif section = "form">
        <section id="info" class="d-none d-md-block col-md-6 col-lg-4 pt-5">
            <div class="row">
                <div class="col-12 d-flex flex-column align-items-center text-center text-sm-left">
                    <div id="mindef-logo"><img src="${url.resourcesPath}/img/minarm_logo.png" alt="Logo MinArm"/></div>
                    <p class="mt-3">${msg("loginTitleHtml",(realm.displayNameHtml!''))?no_esc}</p>
                </div>
                <div class="col-12 pl-3 mt-5 text-center">
                    ${msg("register.info.slogan")}
                </div>
            </div>
        </section>
        <section id="registration" class="col-12 col-md-6 col-lg-8">
            <#if realm.internationalizationEnabled>
                <div id="kc-locale" class="row d-flex align-items-center">
                    <div class="col-12 col-md-6">
                        <small class="text-muted">${msg("register.create.alreadyAccount")}<a href="${url.loginUrl}">${msg("backToLogin")?no_esc}</a></small>
                    </div>
                    <div id="kc-locale-wrapper" class="col-12 col-md-6 d-flex flex-column-reverse align-items-end justify-content-end">
                        <button class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="kc-current-locale-link">${locale.current}</button>
                        <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" id="kc-locale-dropdown">
                            <#list locale.supported as l>
                                <a class="dropdown-item ${(locale.current == l.label!)?then('active','')}" href="${l.url}">${l.label}</a>
                            </#list>
                        </div>
                    </div>
                </div>
            </#if>
            <header class="row mb-3">
                <div id="logo-wrapper" class="col-12 d-flex flex-column flex-sm-row align-items-center justify-content-sm-center text-center text-sm-left">
                    <img id="logo" src="${url.resourcesPath}/img/logo.png" alt="Logo Ministère des armées" class="mr-3" />
                    ${msg("loginTitleHtml",(realm.displayNameHtml!''))?no_esc}
                </div>
            </header>
            <div class="row">
                <#if message?has_content>
                <div id="messages" class="col-12 mt-5">
                    <#if message.type = 'error'>
                    <div class="alert alert-danger">
                        <#else>
                        <div class="alert alert-${message.type}">
                            </#if>
                            <span class="kc-feedback-text">${message.summary?no_esc}</span>
                        </div>
                    </div>
                    </#if>
                </div>
                <#if social.providers??>
                    <#list social.providers as p>
                        <!-- We only want Franceconnect display here -->
                        <#if p.alias == "franceconnect">
                            <div id="" class="col-12 mt-5 d-flex flex-column justify-content-center align-items-center">
                                <p class="text-justify font-weight-light">
                                    ${msg("franceconnect.description")}
                                </p>
                                <a class="zocial ${p.providerId}"
                                   href="${p.loginUrl}" id="zocial-${p.alias}"
                                   alt="identification FranceConnect">
                                </a>
                                <a class="mt-2 font-weight-light" href="https://franceconnect.gouv.fr/">${msg("franceconnect.whatis")}</a>
                                <p id="loginChoiceSeparator" class="around-line-separator mt-3 mb-3 col-12 col-md-8"> <span>${msg("or")}</span></p>
                            </div>
                        </#if>
                    </#list>
                </#if>
                <section id="form" class="row">
                    <header id="login-caption" class="col-12">
                        ${msg("register.create.account")}
                    </header>

                    <form id="kc-register-form" class="col-12" action="${url.registrationAction}" method="post">

                        <#if !realm.registrationEmailAsUsername>
                            <div class="form-group">
                                <label for="username" class="required">${msg("username")}</label>
                                <input type="text" id="username" class="form-control" name="username" value="${(register.formData.username!'')}" autocomplete="username"  required="required"/>
                            </div>
                        </#if>

                        <div id="email-group" class="form-group">
                            <label for="email" class="required">${msg("email")}</label>
                            <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp"
                                   value="${(register.formData.email!'')}"
                                   autocomplete="email"  required="required" placeholder="${msg("input.placeholder.email")}">
                            <small id="email-hint" class="form-text text-info">${msg("email.usePrivateEmail")?no_esc}</small>
                            <small id="email-hint" class="text-danger d-none">${msg("email.badEmail")?no_esc}</small>
                        </div>
                        <#if passwordRequired??>
                            <div class="form-group">
                                <label for="password" class="required">${msg("password")}</label>
                                <input type="password" class="form-control" id="password"
                                       name="password" autocomplete="new-password"  required="required" placeholder="${msg("input.placeholder.password")}" aria-describedby="passwordHelp">
                                <small id="password-hint" class="form-text text-muted text-justify text-info">
                                    ${(htmlPolicies?no_esc)!""}
                                </small>
                            </div>
                            <div class="form-group">
                                <label for="password-confirm" class="required">${msg("passwordConfirm")}</label>
                                <input type="password" class="form-control" id="password-confirm" name="password-confirm" placeholder="${msg("input.placeholder.password-confirm")}" aria-describedby="confirmhelp">
                            </div>
                        </#if>

                        <div class="form-group">
                            <label for="firstname" class="required">${msg("firstName")}</label>
                            <input type="text" class="form-control" id="firstname" name="firstName" value="${(register.formData.firstName!'')}"  required="required" placeholder="${msg("input.placeholder.firstname")}">
                        </div>
                        <div class="form-group">
                            <label for="lastName" class="required">${msg("lastName")}</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" value="${(register.formData.lastName!'')}"  required="required" placeholder="${msg("input.placeholder.lastname")}">
                        </div>
                        <div class="form-group">
                            <label for="gender" class="required">${msg("gender")}</label>
                            <#if genders??>
                                <select class="form-control" id="gender" name="gender" required="required">
                                    <option value="" disabled="disabled" <#if !(register.formData.gender)??>selected="selected"</#if>>${msg("input.empty")}</option>
                                    <#list genders as gender>
                                        <option value="${gender.name}" <#if (register.formData.gender)! == gender.name>selected="selected"</#if>>${gender.description}</option>
                                    </#list>
                                </select>
                            <#else>
                                <select class="form-control" id="gender" name="gender" disabled="disabled"></select>
                            </#if>
                        </div>
                        <div  id="nativeDatePicker" class="form-group">
                            <label id="nativeDatePickerLabel" for="birthdate" class="required">${msg("birthDate")}</label>
                            <input type="date" class="form-control" id="birthdate" name="birthdate"
                                   pattern="(0[1-9]|1[0-9]|2[0-9]|3[01]).(0[1-9]|1[012]).[0-9]{4}"
                                   value="${(register.formData.birthdate!'')}"
                                   title="${msg("birthDate.title")}"  required="required" placeholder="${msg("input.placeholder.birthdate")}"/>
                        </div>
                        <div  id="fallbackDatePicker" class="form-group">
                            <label class="required">${msg("birthDate")}</label>
                            <div class="row">
                                <div class="col-sm-12 col-md-4">
                                    <label for="day">${msg("birthDate.day")} :</label>
                                    <select id="day" name="day" class="form-control">
                                        <option selected="selected" value="${(register.formData.day!'')}">${(register.formData.day!'')}</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-4">
                                    <label for="month">${msg("birthDate.month")} :</label>
                                    <select id="month" name="month" class="form-control">
                                        <option ${('01' == register.formData.month!)?then('selected','')} value="01">${msg("birthDate.january")}</option>
                                        <option ${('02' == register.formData.month!)?then('selected','')} value="02">${msg("birthDate.february")}</option>
                                        <option ${('03' == register.formData.month!)?then('selected','')} value="03">${msg("birthDate.march")}</option>
                                        <option ${('04' == register.formData.month!)?then('selected','')} value="04">${msg("birthDate.april")}</option>
                                        <option ${('05' == register.formData.month!)?then('selected','')} value="05">${msg("birthDate.may")}</option>
                                        <option ${('06' == register.formData.month!)?then('selected','')} value="06">${msg("birthDate.june")}</option>
                                        <option ${('07' == register.formData.month!)?then('selected','')} value="07">${msg("birthDate.july")}</option>
                                        <option ${('08' == register.formData.month!)?then('selected','')} value="08">${msg("birthDate.august")}</option>
                                        <option ${('09' == register.formData.month!)?then('selected','')} value="09">${msg("birthDate.september")}</option>
                                        <option ${('10' == register.formData.month!)?then('selected','')} value="10">${msg("birthDate.october")}</option>
                                        <option ${('11' == register.formData.month!)?then('selected','')} value="11">${msg("birthDate.november")}</option>
                                        <option ${('12' == register.formData.month!)?then('selected','')} value="12">${msg("birthDate.december")}</option>
                                    </select>
                                </div>
                                <div class="col-sm-12 col-md-4">
                                    <label for="year">${msg("birthDate.year")} :</label>
                                    <select id="year" name="year" class="form-control">
                                        <option selected="selected" value="${(register.formData.year!'')}">${(register.formData.year!'')}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="country" class="required">${msg("birthCountry")}</label>
                            <#if countries??>
                                <select class="form-control" id="birthcountry" name="birthcountry" required="required">
                                    <option value="" disabled="disabled">${msg("input.empty")}</option>
                                    <#list countries as birthcountry>
                                        <#if register.formData.birthcountry??>
                                            <option value="${birthcountry.inseeCode}" <#if register.formData.birthcountry == birthcountry.inseeCode>selected="selected"</#if>>${birthcountry.countryName}</option>
                                        <#else>
                                            <option value="${birthcountry.inseeCode}" <#if '99100FR' == birthcountry.inseeCode>selected="selected"</#if>>${birthcountry.countryName}</option>
                                        </#if>
                                    </#list>
                                </select>
                            <#else>
                                <select class="form-control" id="country" name="birthcountry" disabled="disabled"></select>
                            </#if>
                        </div>
                        <div id="birthPlaceGroup" class="form-group">
                            <label for="birthplace" class="required">${msg("birthPlace")}</label>
                            <input type="text" id="birthplace" name="birthplace" class="${properties.kcInputClass!}" value="${(register.formData.birthplace)!}" placeholder="${msg("input.placeholder.birthplace")}"
                                   title="${msg("birthPlace")}"  required="required" disabled="disabled" />
                        </div>
                        <#if recaptchaRequired??>
                            <div class="form-group">
                                <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                            </div>
                        </#if>
                        <button id="send" type="submit" class="btn btn-primary  btn-lg col-12 mb-2">${msg("doRegister")}</button>
                    </form>
                </section>
        </section>
    </#if>
</@layout.registrationLayout>