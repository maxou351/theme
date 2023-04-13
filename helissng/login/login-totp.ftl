<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("doLogIn")}
    <#elseif section = "form">
        <div id="login-totp-wrapper" class="col-12 d-flex align-items-center generic-background">
            <form id="kc-totp-login-form" class="col-12" action="${url.loginAction}" method="post">
                <div class="form-group row">
                    <label for="totp" class="col-12 col-sm-3 required">${msg("loginTotpOneTime")}</label>
                    <div class="col-12 col-sm-9">
                        <input id="totp" name="totp" autocomplete="off" type="text" class="${properties.kcInputClass!}" autofocus />
                    </div>
                </div>

                <div class="form-group row">
                    <div id="kc-form-buttons" class="col-12 text-right">
                        <div class="${properties.kcFormButtonsWrapperClass!}">
                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                            <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="cancel" id="kc-cancel" type="submit" value="${msg("doCancel")}"/>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>