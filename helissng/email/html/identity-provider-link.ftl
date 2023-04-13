<#ftl output_format="XHTML">
<html>
<body>
${msg("identityProviderLinkBodyHtml", identityProviderAlias, realmName, identityProviderContext.username, link?replace('http://', 'https://'), linkExpiration?replace('http://', 'https://'))?no_esc}
</body>
</html>