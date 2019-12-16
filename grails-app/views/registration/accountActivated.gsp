<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="section" content="home"/>
    <title>${message(code:"accountActivated.title", default:"Account activated")} | ${grailsApplication.config.skin.orgNameLong}</title>
    <asset:stylesheet src="application.css" />
</head>
<body>
<div class="row">
    <h1>
        ${message(code:"accountActivated.header", default:"Please check your email to activate your account!")}
    </h1>

    <div class="row">
        <div class="col-md-12">
            <div class="well well-lg">
                ${message(code:"accountActivated.info1", default:"Thank you for registering with the ")}${grailsApplication.config.skin.orgNameLong}
                ${message(code:"accountActivated.info2", default:"To complete your account registration, please check your email and <strong>click the link provided in the email</strong>.<br/>If you have any problems please email ")} <a href="mailto:${grailsApplication.config.supportEmail}">${grailsApplication.config.supportEmail}</a>.
            </div>
        </div>
   </div>
</div>
</body>
</html>
