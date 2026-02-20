<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"     prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"      prefix="fmt" %>

<fmt:setLocale value="en_IN"/>

<jsp:include page="header.jsp"/>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500;600&display=swap');
  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(14px); }
    to   { opacity: 1; transform: translateY(0); }
  }
  body {
    background-color: #f4f6f9;
    color: #1a1e2a;
    font-family: 'DM Sans', sans-serif;
    margin: 0;
    min-height: 100vh;
  }
  .tbl-row:hover td {
    background: #f0f4ff !important;
  }
</style>

<div style="display:flex;align-items:center;justify-content:space-between;max-width:1100px;margin:2.5rem auto 2rem;padding:0 2rem 1.5rem;border-bottom:2px solid #e2e8f0;flex-wrap:wrap;gap:1rem;">
  <div>
    <h1 style="font-family:'Playfair Display',Georgia,serif;font-size:2rem;font-weight:700;color:#1a1e2a;letter-spacing:-0.01em;margin:0 0 6px 0;">All Accounts</h1>
    <div style="width:40px;height:3px;background:#3b5bdb;border-radius:2px;"></div>
  </div>
  <a href="${pageContext.request.contextPath}/accounts?action=new"
     style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.6rem 1.3rem;background:#3b5bdb;color:#ffffff;border:none;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:600;text-decoration:none;letter-spacing:0.02em;box-shadow:0 2px 8px rgba(59,91,219,0.25);"
     onmouseover="this.style.background='#2f4ac7';this.style.boxShadow='0 4px 16px rgba(59,91,219,0.4)'"
     onmouseout="this.style.background='#3b5bdb';this.style.boxShadow='0 2px 8px rgba(59,91,219,0.25)'"
  >+ Open New Account</a>
</div>

<div style="max-width:1100px;margin:0 auto;padding:0 2rem 3rem;">
<c:choose>
<c:when test="${empty accounts}">
  <div style="text-align:center;padding:5rem 2rem;background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;box-shadow:0 2px 12px rgba(0,0,0,0.06);animation:fadeUp 0.4s ease both;">
    <div style="font-size:3rem;margin-bottom:1rem;opacity:0.35;">🏦</div>
    <p style="font-size:1rem;color:#64748b;font-family:'DM Sans',sans-serif;margin:0;">
      No accounts found.
      <a href="${pageContext.request.contextPath}/accounts?action=new"
         style="color:#3b5bdb;text-decoration:none;font-weight:600;"
         onmouseover="this.style.textDecoration='underline'"
         onmouseout="this.style.textDecoration='none'"
      >Open the first account</a>.
    </p>
  </div>
</c:when>
<c:otherwise>
  <div style="background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;overflow:hidden;box-shadow:0 2px 16px rgba(0,0,0,0.07);animation:fadeUp 0.4s ease both;">
    <table style="width:100%;border-collapse:collapse;">
      <thead>
        <tr>
          <th style="background:#f8fafc;padding:0.9rem 1.2rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Account Number</th>
          <th style="background:#f8fafc;padding:0.9rem 1.2rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Holder Name</th>
          <th style="background:#f8fafc;padding:0.9rem 1.2rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Type</th>
          <th style="background:#f8fafc;padding:0.9rem 1.2rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Balance (₹)</th>
          <th style="background:#f8fafc;padding:0.9rem 1.2rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Status</th>
          <th style="background:#f8fafc;padding:0.9rem 1.2rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="acc" items="${accounts}">
          <tr class="tbl-row">
            <td style="padding:1rem 1.2rem;border-bottom:1px solid #f1f5f9;font-size:0.9rem;vertical-align:middle;">
              <strong style="font-family:'Playfair Display',Georgia,serif;color:#3b5bdb;font-size:0.95rem;letter-spacing:0.03em;">${acc.accountNumber}</strong>
            </td>
            <td style="padding:1rem 1.2rem;border-bottom:1px solid #f1f5f9;font-size:0.9rem;color:#1e293b;vertical-align:middle;font-family:'DM Sans',sans-serif;font-weight:500;">
              ${acc.holderName}
            </td>
            <td style="padding:1rem 1.2rem;border-bottom:1px solid #f1f5f9;vertical-align:middle;">
              <c:choose>
                <c:when test="${acc.accountTypeName.toLowerCase() == 'savings'}">
                  <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#dbeafe;color:#1d4ed8;border:1px solid #bfdbfe;font-family:'DM Sans',sans-serif;">${acc.accountTypeName}</span>
                </c:when>
                <c:when test="${acc.accountTypeName.toLowerCase() == 'current'}">
                  <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#ffedd5;color:#c2410c;border:1px solid #fed7aa;font-family:'DM Sans',sans-serif;">${acc.accountTypeName}</span>
                </c:when>
                <c:otherwise>
                  <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#fef9c3;color:#a16207;border:1px solid #fde68a;font-family:'DM Sans',sans-serif;">${acc.accountTypeName}</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td style="padding:1rem 1.2rem;border-bottom:1px solid #f1f5f9;vertical-align:middle;font-family:'Playfair Display',Georgia,serif;font-size:1rem;font-weight:700;color:#15803d;">
              ₹<fmt:formatNumber value="${acc.balance}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <td style="padding:1rem 1.2rem;border-bottom:1px solid #f1f5f9;vertical-align:middle;">
              <c:choose>
                <c:when test="${acc.active}">
                  <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#dcfce7;color:#15803d;border:1px solid #bbf7d0;font-family:'DM Sans',sans-serif;">Active</span>
                </c:when>
                <c:otherwise>
                  <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#fee2e2;color:#b91c1c;border:1px solid #fecaca;font-family:'DM Sans',sans-serif;">Closed</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td style="padding:1rem 1.2rem;border-bottom:1px solid #f1f5f9;vertical-align:middle;">
              <div style="display:flex;gap:0.5rem;flex-wrap:wrap;">
                <a href="${pageContext.request.contextPath}/accounts?action=view&accountNumber=${acc.accountNumber}"
                   style="display:inline-flex;align-items:center;padding:0.35rem 0.9rem;background:#3b5bdb;color:#ffffff;border:1px solid #3b5bdb;border-radius:6px;font-family:'DM Sans',sans-serif;font-size:0.8rem;font-weight:600;text-decoration:none;white-space:nowrap;box-shadow:0 1px 4px rgba(59,91,219,0.2);"
                   onmouseover="this.style.background='#2f4ac7'"
                   onmouseout="this.style.background='#3b5bdb'"
                >View</a>
                <a href="${pageContext.request.contextPath}/transactions?action=history&accountNumber=${acc.accountNumber}"
                   style="display:inline-flex;align-items:center;padding:0.35rem 0.9rem;background:#f8fafc;color:#475569;border:1px solid #e2e8f0;border-radius:6px;font-family:'DM Sans',sans-serif;font-size:0.8rem;font-weight:500;text-decoration:none;white-space:nowrap;"
                   onmouseover="this.style.background='#e2e8f0';this.style.color='#1e293b'"
                   onmouseout="this.style.background='#f8fafc';this.style.color='#475569'"
                >History</a>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  <p style="text-align:right;margin-top:0.75rem;font-size:0.78rem;color:#94a3b8;font-family:'DM Sans',sans-serif;">
    Showing <c:out value="${accounts.size()}"/> account(s)
  </p>
</c:otherwise>
</c:choose>
</div>

<jsp:include page="footer.jsp"/>
