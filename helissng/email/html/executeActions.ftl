<#ftl output_format="XHTML">
<#outputformat "plainText">
<#assign requiredActionsText><#if requiredActions??><#list requiredActions><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#sep></#items></#list></#if></#assign>
</#outputformat>

<html>
<body>
${msg("executeActionsBodyHtml",link?replace('http://', 'https://'), linkExpiration?replace('http://', 'https://'), realmName, requiredActionsText)?no_esc}
</body>
</html>
