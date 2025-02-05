<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=basePath%>">
<title>Tag</title>

<link rel="stylesheet" href="css/reset.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/base.css" type="text/css" media="all" />

<link rel="stylesheet" href="css/slide.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/custom.css" type="text/css" media="all" />

<link rel="stylesheet" href="css/page/page.css" type="text/css"
    media="all" />

<script src="jquery/jquery-1.11.0.min.js"></script>

<style type="text/css">
    .tag-form .line {
        height: 40px;
    }
    
    .tag-form .line .label,.tag-form .line .cencelBtn {
        float: left;
        width: 350px;
        text-align: right;
    }
    
    .tag-form .value,.tag-form .submitBtn {
        float: left;
        width: 800px;
    }
    
    .tag-form .value select {
        margin-left: 10px;
    }
    
    .tag-form .tag-select {
        float: left;
        min-width: 100px;
    }
    
    .linkAgeTagJson {
        display: none;
    }
</style>

</head>
<body>

    <jsp:include page="../common/head.jsp"></jsp:include>

    <div class="main">

        <jsp:include page="../common/crumb.jsp"></jsp:include>

        <jsp:include page="../common/left.jsp"></jsp:include>

        <div class="content">

            <form class="tag-form" action="tag/save" method="post">
            
                <div class='linkAgeTagJson'>
                    ${tagInheritJson }
                </div>

                <div class="line">
                    <div class="label">Parent Tag</div>
                    <div class="value">
                        
                        <c:choose>
                            <c:when test="${fn:length(tagSequenceMap) > 0 }">
                                <c:forEach var="tagEntry" items="${tagSequenceMap }" varStatus="status">
                                    <div >
                                        <c:choose>
                                            <c:when test="${fn:length(tagSequenceMap) ==  status.index + 1}">
                                                <select name="parentTagId" class="level${status.index + 1} tag-select">
                                                    <c:forEach var="tag" items="${tagEntry.value }">
                                                        <c:choose>
                                                            <c:when test="${tagEntry.key == tag.id }">
                                                                <option selected="selected" value="${tag.id }">${tag.name }</option>
                                                            </c:when>
                                                            
                                                            <c:otherwise>
                                                                <option value="${tag.id }">${tag.name }</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </select>
                                             </c:when>
                                             
                                             <c:otherwise>
                                                <select class="level${status.index + 1} tag-select">
                                                    <c:forEach var="tag" items="${tagEntry.value }">
                                                        <c:choose>
                                                            <c:when test="${tagEntry.key == tag.id }">
                                                                <option selected="selected" value="${tag.id }">${tag.name }</option>
                                                            </c:when>
                                                            
                                                            <c:otherwise>
                                                                <option value="${tag.id }">${tag.name }</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </select>
                                             </c:otherwise>
                                        
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </c:when>
                            
                            <c:otherwise>
                                NULL
                            </c:otherwise>
                        </c:choose>
                        
                    </div>
                </div>

                <div class="line">
                    <div class="label">Tag Name</div>
                    <div class="value">
                        <c:choose>
                            <c:when test="${null != tag }">
                                <input name="name" value="${tag.name }">
                            </c:when>
                            <c:otherwise>
                                <input name="name">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="line">
                    <div class="cencelBtn">
                        <input class="btn btn-cancel btn-middle radius" type="button" value="Cancel">
                    </div>
                    <div class="submitBtn">
                        <input class="btn btn-normal btn-middle radius" type="submit" value="Submit">
                    </div>
                </div>
            </form>

        </div>
    </div>
    
    <script type="text/javascript">
    
        var tagLinkAgeJson = JSON.parse($(".linkAgeTagJson").text());
        
        function buildSelectContent(tagId) {
            
            var options = "";
            
            try {
                var tagJson = tagLinkAgeJson[tagId];
                $.each(tagJson, function(key, value) {
    				var option = "<option value='" + key + "'>" + value + "</div>";
                    options += option;
                });
            } catch (e) {
                console.log(e.message);
            }
            
            return options;
        }
        
        for(var i = 1; i <= 10; i ++) {
            var parentSelect = $(".tag-form .level" + i);
            if (parentSelect.length > 0) {
                
                parentSelect.bind("change", function() {
                    var levelClass = this.className.replace(" tag-select", "");
                    var levelNum = parseInt(levelClass.replace("level", ""), 10);
                    var childSelect = $(".tag-form .level" + (levelNum + 1));
                    
                    if (childSelect.length > 0 ) {
                        var options = buildSelectContent(this.value);
                        
                        if (options.length > 0) {
                            $(childSelect).show();
                            $(childSelect).html(options);
                        } else {
                            $(childSelect).hide();
                        }
                        
                    }
                });
            }
        }
    
    </script>

</body>
</html>