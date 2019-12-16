<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="section" content="home"/>
    <title>${message(code:"accountActivatedSuccessful.title", default:"Account created")} | ${grailsApplication.config.skin.orgNameLong}</title>
    <asset:stylesheet src="application.css" />
</head>
<body>
<div class="row" style="padding-left:20px">
    <h1>
        ${message(code:"accountActivatedSuccessful.info", default:"Congratulations! Your account has been activated successfully.")}
    </h1>

    <div class="row">
        <div class="col-md-12">
            <div class="well well-lg">
                ${message(code:"accountActivatedSuccessful.toLink1", default:"Please login in order to access ")}
                <a href="${grailsApplication.config.security.cas.loginUrl}?email=${user.email}&service=${grailsApplication.config.redirectAfterFirstLogin}">  ${message(code:"accountActivatedSuccessful.toLink2", default:"My Profile")}</a>.
            </div>
        </div>
    </div>
</div>
</body>
</html>