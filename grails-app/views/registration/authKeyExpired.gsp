<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="section" content="home"/>
    <title><g:message code="auth.key.expired.title" /></title>
    <asset:stylesheet src="application.css" />
</head>
<body>
<div class="row">
    <h1><g:message code="auth.key.expired.header" /></h1>
    <div class="row">
        <p>
            <g:message code="auth.key.expired.initial.description" /><br/>
            <g:message code="auth.key.expired.msg1" /> <g:link controller="registration" action="forgottenPassword"><g:message code="auth.key.expired.msg2" /></g:link> <g:message code="auth.key.expired.msg3" />
            <br/>
            <g:message code="auth.key.expired.msg4" /> <g:link controller="registration" action="forgottenPassword"><g:message code="auth.key.expired.msg5" /></g:link>.

            <br/>
            <g:message code="auth.key.expired.mailto" args="[grailsApplication.config.supportEmail]" />
        </p>
    </div>
</div>
</body>
</html>
