<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
    <title>${viewName}</title>

    <!-- ############# css ################# -->
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/icons.css"/>
    <link
            rel="stylesheet"
            type="text/css"
            href="/Oskari${path}/oskari.min.css"/>
    <style type="text/css">
        @media screen {
            body {
                margin: 0;
                padding: 20px;

                height: 100vh;
                width: 100%;
            }
            #oskari {
                /* for application to set */
                height: 100%;
                width: 100%;
            }
            #maptools {
                /* for application to set */
                background-color: #333438;
            }

            #login {
                margin-left: 5px;
            }

            #login input[type="text"], #login input[type="password"] {
                width: 90%;
                margin-bottom: 5px;
                background-image: url("/Oskari/${version}/resources/images/forms/input_shadow.png");
                background-repeat: no-repeat;
                padding-left: 5px;
                padding-right: 5px;
                border: 1px solid #B7B7B7;
                border-radius: 4px 4px 4px 4px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
                color: #878787;
                font: 13px/100% Arial,sans-serif;
            }
            #login input[type="submit"] {
                width: 90%;
                margin-bottom: 5px;
                padding-left: 5px;
                padding-right: 5px;
                border: 1px solid #B7B7B7;
                border-radius: 4px 4px 4px 4px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) inset;
                color: #878787;
                font: 13px/100% Arial,sans-serif;
            }
            #login p.error {
                font-weight: bold;
                color : red;
                margin-bottom: 10px;
            }

            #login a {
                color: #FFF;
                padding: 5px;
            }

        }
    </style>
    <!-- ############# /css ################# -->
</head>
<body>

<div id="oskari">
    <!--
         Container to render Oskari in. Consider creating nav element and div#contentMap in JS-code
         TODO: frontend should generate this as well. An empty element with id="oskari" or similar should be enough.
     -->
    <nav id="maptools">
        <div id="logobar">
            <!-- Container for logo TODO: move it to JS -->
        </div>
        <div id="menubar">
            <!-- Container for menu items or "tiles" from bundles -->
        </div>

        <div id="toolbar">
        </div>
        <!-- More app-specific stuff TODO: move it to JS  -->
        <div id="login">
            <c:choose>
                <c:when test="${!empty loginState}">
                    <p class="error"><spring:message code="invalid_password_or_username" text="Invalid password or username!" /></p>
                </c:when>
            </c:choose>
            <c:choose>
                <%-- If logout url is present - so logout link --%>
                <c:when test="${!empty _logout_uri}">
                    <form action="${pageContext.request.contextPath}${_logout_uri}" method="POST" id="logoutform">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <a href="${pageContext.request.contextPath}${_logout_uri}" style="color: #ffffff;" onClick="jQuery('#logoutform').submit();return false;"><spring:message code="logout" text="Logout" /></a>
                    </form>
                    <%-- oskari-profile-link id is used by the personaldata bundle - do not modify --%>
                    <a href="${pageContext.request.contextPath}${_registration_uri}" style="color: #ffffff;" id="oskari-profile-link"><spring:message code="account" text="Account" /></a>
                </c:when>
                <%-- Otherwise show appropriate logins --%>
                <c:otherwise>
                    <c:if test="${!empty _login_uri && !empty _login_field_user}">
                        <form action='${pageContext.request.contextPath}${_login_uri}' method="post" accept-charset="UTF-8">
                            <input size="16" id="username" name="${_login_field_user}" type="text" placeholder="<spring:message code="username" text="Username" />" autofocus
                                   required>
                            <input size="16" id="password" name="${_login_field_pass}" type="password" placeholder="<spring:message code="password" text="Password" />" required>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="submit" id="submit" value="<spring:message code="login" text="Log in" />">
                        </form>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>


        <div id="demolink">
            <a href="#" style="margin: 10px; color: #ffd400;"
            onClick="changeAppsetup()">EPSG:3067</a>
        </div>
    </nav>
    <%--
        This is commented out as frontend generates these 
        <div id="contentMap">
            <!-- Container for the "main content" ie map including the mobile toolbar etc -->
            <div id="mapdiv">
                <!-- Container root for map -->
            </div>
    </div>
     --%>
</div>


<!-- ############# Javascript ################# -->

<script>
function changeAppsetup() {
    var appsetup = Oskari.app.getSystemDefaultViews().filter(function (appsetup) {
        return  appsetup.name === 'Finland';
    });

    window.location=window.location.pathname + '?uuid=' + appsetup[0].uuid;
    return false;
}
</script>
<!--  OSKARI -->

<script type="text/javascript">
    var ajaxUrl = '${ajaxUrl}';
    var controlParams = ${controlParams};
</script>
<%-- Pre-compiled application JS, empty unless created by build job --%>
<script type="text/javascript"
        src="/Oskari${path}/oskari.min.js">
</script>
<%--language files --%>
<script type="text/javascript"
        src="/Oskari${path}/oskari_lang_${language}.js">
</script>

<script type="text/javascript"
        src="/Oskari${path}/index.js">
</script>


<!-- ############# /Javascript ################# -->
</body>
</html>
