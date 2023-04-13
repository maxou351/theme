<#ftl output_format="XHTML">
<html>
<body>
${msg("passwordResetBodyHtml",link?replace('http://', 'https://'), linkExpiration?replace('http://', 'https://'), realmName)?no_esc}
</body>
</html>