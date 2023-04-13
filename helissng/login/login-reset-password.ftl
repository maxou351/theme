<#ftl output_format="XHTML">
<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("emailForgotTitle")}
    <#elseif section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <div id="reset-password-wrapper" class="col-12 d-flex align-items-center justify-content-center background-with-modal">
            <div id="modal-reset-password" class="col-12 col-md-8 col-xl-6">
                <form class="col-12" id="kc-reset-password-form" action="${url.loginAction}" method="post">
                    <div class="form-group row ">
                        <label for="username" class="col-12 col-sm-2 required"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                        <div class="${properties.kcInputWrapperClass!}">
                            <input type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus  placeholder="${msg("input.placeholder.email")}"/>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div id="kc-form-options" class="col-12 offset-sm-2 col-sm-6">
                                <a href="${url.loginUrl}">${msg("backToLogin")?no_esc}</a>
                        </div>

                        <div id="kc-form-buttons" class="col-12 col-sm-4 submit text-sm-right">
                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}"/>
                        </div>
                        
                    </div>
                </form>
            <div>
        </div>
    </#if>
</@layout.registrationLayout>
