<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
    <div id="verify-email-wrapper" class="col-12 d-flex align-items-center justify-contentcenter generic-background">
        <p class="instruction col-12 col-md-6">
            ${msg("emailVerifyInstruction1")}
        </p>
        <p class="instruction col-12 col-md-6">
            ${msg("emailVerifyInstruction2")} <a href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
        </p>
    </#if>
</@layout.registrationLayout>