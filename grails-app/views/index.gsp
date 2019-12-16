<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="section" content="home"/>
    <title>${grailsApplication.config.skin.orgNameShort} ${message(code:"index.accounts.accounts.title", default:"accounts")}</title>
    <asset:stylesheet src="application.css" />
</head>
<body>
<div class="row">
    <div class="col-md-12" id="page-body" role="main">

        <g:if test="${flash.errorMessage || flash.message}">
            <div class="col-md-12">
                <div class="alert alert-danger">
                    <button class="close" onclick="$('.alert').fadeOut();" href="#">×</button>
                    ${flash.errorMessage?:flash.message}
                </div>
            </div>
        </g:if>

        <h1>${grailsApplication.config.skin.orgNameShort}  ${message(code:"index.accounts.header", default:"accounts")}</h1>
        <ul class="userdetails-menu">
            <li><g:link controller="registration" action="createAccount">${message(code:"index.accounts.newAccount", default:"Create a new account")}</g:link></li>
            <li><g:link controller="registration" action="forgottenPassword">${message(code:"index.accounts.passwordReset", default:"Reset my password")}</g:link></li>
            <li><g:link controller="profile">${message(code:"index.accounts.myProfile", default:"My profile")}</g:link></li>
        </ul>

    </div>
    <auth:ifAllGranted roles="ROLE_ADMIN">
        <div style="color:white;" class="pull-right">
            <g:link style="color:#DDDDDD; font-weight:bold;" controller="admin">${message(code:"index.accounts.adminTools", default:"Admin tools")} (${grailsApplication.config.skin.orgNameShort} ${message(code:"index.accounts.adminOnly", default:"administrators only")})</g:link>
        </div>
    </auth:ifAllGranted>
</div>
</body>
</html>
