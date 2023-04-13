<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
     <div id="update-profile-wrapper" class="col-12 d-flex align-items-center justify-content-center background-with-modal">
        <div class="modal-update-profile col-12 col-md-8 col-xl-6">
        <form id="kc-update-profile-form" action="${url.loginAction}" method="post" class="col-12">
            <#if user.editUsernameAllowed>
                <div class="form-group row">
                    <label for="username" class="col-12 col-sm-3">${msg("username")}</label>
                    <div class="col-12 col-sm-9">
                        <input type="text" id="username" name="username" value="${(user.username!'')}" class="${properties.kcInputClass!}"/>
                    </div>
                </div>
            </#if>
            <div class="form-group row">
                <label for="email" class="col-12 col-sm-3">${msg("email")}</label>
                <div class="col-12 col-sm-9">
                    <input type="text" id="email" name="email" value="${(user.email!'')}" class="${properties.kcInputClass!}" />
                </div>
            </div>

            <div class="form-group row">
                <label for="firstName" class="col-12 col-sm-3">${msg("firstName")}</label>
                <div class="col-12 col-sm-9">
                    <input type="text" id="firstName" name="firstName" value="${(user.firstName!'')}" class="${properties.kcInputClass!}" />
                </div>
            </div>

            <div class="form-group row">
                <label for="lastName" class="col-12 col-sm-3">${msg("lastName")}</label>
                <div class="col-12 col-sm-9">
                    <input type="text" id="lastName" name="lastName" value="${(user.lastName!'')}" class="${properties.kcInputClass!}" />
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                </div>
            </div>
        </form>
        </div>
    </#if>
</@layout.registrationLayout>
