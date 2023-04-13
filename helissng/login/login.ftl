<#ftl output_format="XHTML">
<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
        ${msg("loginTitleHtml",(realm.displayNameHtml!''))?no_esc}
    <#elseif section = "form">
        <section id="login" class="col-12 col-md-6 col-lg-4">
            <#if realm.internationalizationEnabled>
                <div id="kc-locale" class="row d-block d-md-none ">
                    <div id="kc-locale-wrapper" class="col-12 d-flex flex-column-reverse align-items-end justify-content-end">
                        <button class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="kc-current-locale-link">${locale.current}</button>
                        <div class="dropdown-menu dropdown-menu-right" id="kc-locale-dropdown">
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
                <div class="col-12">
                    <#if message?has_content>
                        <#if message.type = 'error'>
                            <div id="messages" class="col-12 mt-5">
                                <div class="alert alert-danger">
                                    <span class="kc-feedback-text">${message.summary?no_esc}</span>
                                </div>
                            </div>
                        <#else>
                            <div id="messages" class="col-12 mt-5">
                                <div class="alert alert-${message.type}">
                                    <span class="kc-feedback-text">${message.summary?no_esc}</span>
                                </div>
                            </div>
                        </#if>
                    </#if>
                    <#if social.providers??>
                        <#list social.providers as p>
                            <#if p.alias == "franceconnect">
                                <section id="france-connect">
                                    <p class="text-justify font-weight-light">
                                        ${msg("franceconnect.description")}
                                    </p>
                                    <div class="col-12 d-flex flex-column justify-content-center align-items-center">
                                        <a class="zocial ${p.providerId}" href="${p.loginUrl}" id="zocial-${p.alias}" alt="identification FranceConnect"></a>
                                        <a class="mt-2 font-weight-light" href="https://franceconnect.gouv.fr/">${msg("franceconnect.whatis")}</a>
                                    </div>
                                    <p id="loginChoiceSeparator" class="around-line-separator mt-3 mb-3"> <span>${msg("or")}</span></p>
                                </section>
                            </#if>
                        </#list>
                    </#if>
                    <section id="form" class="row">
                        <header id="login-caption" class="col-12 mb-3">
                            ${msg("login.connection")}
                        </header>
                        <form id="kc-form-login" class="col-12" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                            <div class="form-group">
                                <label for="username"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                                <#if usernameEditDisabled??>
                                    <input tabindex="1" id="username" class="form-control" name="username" value="${(login.username!'')}" type="text" disabled/>
                                <#else>
                                    <input tabindex="1" id="username" class="form-control" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off" placeholder="${msg("input.placeholder.email")}"/>
                                </#if>
                            </div>
                            <div class="form-group">
                                <label for="password">${msg("password")}</label>
                                <input tabindex="2" id="password" class="form-control" name="password" type="password" autocomplete="off"  placeholder="${msg("input.placeholder.password")}"/>
                            </div>
                            <div class="form-group form-check">
                                <#if login.rememberMe??>
                                    <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked>
                                <#else>
                                    <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox">
                                </#if>
                                <label for="rememberMe" class="form-check-label"> ${msg("rememberMe")} </label>
                            </div>
                            <button id="kc-login" type="submit" class="btn btn-primary  btn-lg col-12 mb-2"> ${msg("login.connection")}</button>
                            <#if realm.resetPasswordAllowed>
                                <p><a tabindex="5" href="${url.loginResetCredentialsUrl}"  class="font-weight-light">${msg("doForgotPassword")}</a></p>
                            </#if>
                            <#if realm.password && social.providers??>
                                <#list social.providers as p>
                                    <#if p.alias != "franceconnect">
                                        <a class="btn btn-primary col-12 d-flex justify-content-center align-items-center zocial ${p.providerId}"
                                           href="${p.loginUrl}" id="zocial-${p.alias}">
                                            <img src="${url.resourcesPath}/img/logo-${p.alias}.png" class="mr-2" alt="Provider ${p.alias}"/>
                                            <div class="d-flex flex-column">
                                                <span> ${msg("login.log.with")} </span>
                                                <strong>${p.displayName}</strong>
                                            </div>
                                        </a>
                                    </#if>
                                </#list>
                            </#if>
                        </form>
                    </section>
                    <footer class="row mt-2">
                        <div class="col-12">
                            <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
                                ${msg("noAccount")} <a id="doRegister" tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a>
                            </#if>
                        </div>
                    </footer>
                </div>
            </div>
        </section>
        <section id="presentation" class="d-none d-md-block col-md-6 col-lg-8">
            <#if realm.internationalizationEnabled>
                <div id="kc-locale" class="row">
                    <div id="kc-locale-wrapper" class="col-12 d-flex flex-column-reverse align-items-end justify-content-end">
                        <button class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="kc-current-locale-link">${locale.current}</button>
                        <div class="dropdown-menu dropdown-menu-right" id="kc-locale-dropdown">
                            <#list locale.supported as l>
                                <a class="dropdown-item ${(locale.current == l.label!)?then('active','')}" href="${l.url}">${l.label}</a>
                            </#list>
                        </div>
                    </div>
                </div>
            </#if>
            <div id="slogan" class="row">
                <div class="col-12">
                    <span>${msg("login.slogan.mindefconnect")}</span>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-12  col-lg-6  mb-3">
                    <div class="card">
                        <img src="${url.resourcesPath}/img/dirisi.png" class="card-img-top" alt="Dirisi">
                        <div class="card-body">
                            <p class="card-text  text-center">${msg("login.slogan.dirisi")}</p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-6  col-xlg-4">
                    <div class="card">
                        <img src="${url.resourcesPath}/img/minarm.png" class="card-img-top" alt="MinArm">
                        <div class="card-body">
                            <p class="card-text text-center">${msg("login.slogan.minarm")}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </#if>
</@layout.registrationLayout>
