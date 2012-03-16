<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="f" uri="/WEB-INF/functions.tld"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <title>Users</title>
    <jsp:include page="htmlHead.jsp"/>
  </head>
  <body>
    <jsp:include page="navBar.jsp"/>
    <h1>Users</h1>
    <c:choose>
      <c:when test="${fn:length(userList) == 0}">
        <p>No users</p>
      </c:when>
      <c:otherwise>
        <table>
          <thead>
            <tr>
              <th class="number">Id</th>
              <th>Name</th>
              <th>Organization</th>
              <th>Title</th>
              <th>Email</th>
              <th>Since</th>
			  <security:authorize ifAllGranted="ROLE_ADMIN">
                <th>Enabled</th>
                <th>Admin</th>
              </security:authorize>
              <th><em>Actions</em></th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${userList}" var="user">
	           <tr>
                <td class="number">${user.id}</td>
                <td>${user.name}</td>
                <td>${f:trimToLength(user.organization, 30)}</td>
                <td>${f:trimToLength(user.title, 30)}</td>
                <td>
                  <a href="mailto:${user.email}">
                    ${f:trimToLength(user.email, 30)}
                  </a>
                </td>
                <td>
                  <fmt:formatDate value="${user.created}" pattern="MMM yyyy" />
                </td>
				<security:authorize ifAllGranted="ROLE_ADMIN">
                  <td>${user.enabled? 'Yes' : 'No'}</td>
                  <td>${user.admin? 'Yes' : 'No'}</td>
                </security:authorize>
                <td class="small">
                  <a class="button" href="<c:url value='/user.html?id=${user.id}'/>">View</a>
                  <security:authorize ifAllGranted="ROLE_ADMIN">
                    <a class="button" href="<c:url value='/user_form.html?id=${user.id}'/>">Edit</a>
                    <a class="button" href="<c:url value='/user_delete.html?id=${user.id}'/>"
                      onclick="return confirm('Are you sure you wish to delete this user?');">Delete</a>
                  </security:authorize>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:otherwise>
    </c:choose>
  </body>
</html>