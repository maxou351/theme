<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
    <div id="update-password-wrapper" class="col-12 d-flex align-items-center justify-content-center background-with-modal">

        <div class="modal-update-password col-12 col-md-8 col-xl-6 mt-2">
            <div class="row">
                <#if message?has_content>
                <div id="messages" class="col-12 ">
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
            <div class="row">
                <form id="kc-passwd-update-form" class="col-12" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;"/>
            <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

            <div class="form-group row">
                <label for="password-new" class="col-12 col-sm-3 required">${msg("passwordNew")}</label>
                <div class="col-12 col-sm-9">
                    <input type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}" autofocus autocomplete="new-password" />
                    <small id="password-hint" class="form-text text-muted text-justify text-info">
                        ${(htmlPolicies?no_esc)!""}
                    </small>
                </div>
            </div>

            <div class="form-group row">
                <label for="password-confirm" class="col-12 col-sm-3 required">${msg("passwordConfirm")}</label>
                <div class="col-12 col-sm-9">
                    <input type="password" id="password-confirm" name="password-confirm" class="${properties.kcInputClass!}" autocomplete="new-password" />
                </div>
            </div>

            <div class="form-group row">
                <div id="kc-form-buttons" class="col-12 text-right">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}"/>
                </div>
            </div>
        </form>
            </div>
        </div>
    </div>
    </#if>
</@layout.registrationLayout>
