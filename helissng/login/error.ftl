<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${msg("errorTitle")}
    <#elseif section = "form">
    <div id="error-wrapper" class="col-12 d-flex align-items-center justify-content-center generic-background">
        <div id="kc-error-message"  class="alert alert-danger">
            <p class="instruction">${message.summary}</p>
            <#if client?? && client.baseUrl?has_content>
                <p><a id="backToApplication" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
            </#if>
        </div>
    </div>
    </#if>
</@layout.registrationLayout>