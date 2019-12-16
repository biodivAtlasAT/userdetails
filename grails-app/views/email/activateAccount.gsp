<%@ page contentType="text/html"%>
<html>
  <head><title>${message(code:"activateAccount.title", default:"Activate your account")}</title></head>
  <body>
    <h1>${message(code:"activateAccount.header", default:"Activate your account")}</h1>
    <p>
        ${message(code:"activateAccount.info1", default:"Please click the link below to activate your")} ${orgNameLong} ${message(code:"activateAccount.info2", default:"account")}
    </p>
    <p>
       <a href="${link}">${link}</a>
    </p>
  </body>
</html>