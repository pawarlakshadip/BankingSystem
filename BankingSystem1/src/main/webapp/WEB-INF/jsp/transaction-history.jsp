<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"   %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>

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

<!-- Page Header -->
<div style="display:flex;align-items:center;justify-content:space-between;max-width:1100px;margin:2.5rem auto 2rem;padding:0 2rem 1.5rem;border-bottom:2px solid #e2e8f0;flex-wrap:wrap;gap:1rem;">
  <div>
    <h1 style="font-family:'Playfair Display',Georgia,serif;font-size:1.9rem;font-weight:700;color:#1a1e2a;letter-spacing:-0.01em;margin:0 0 6px 0;">
      ${mini ? 'Mini Statement' : 'Transaction History'}
      <span style="color:#3b5bdb;font-size:1.5rem;"> — ${accountNumber}</span>
    </h1>
    <div style="width:40px;height:3px;background:#3b5bdb;border-radius:2px;"></div>
  </div>
  <a href="${pageContext.request.contextPath}/accounts?action=view&accountNumber=${accountNumber}"
     style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;box-shadow:0 1px 3px rgba(0,0,0,0.06);"
     onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
     onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
  >← Back to Account</a>
</div>

<!-- Main Content -->
<div style="max-width:1100px;margin:0 auto;padding:0 2rem 3rem;">
<c:choose>
<c:when test="${empty transactions}">
  <div style="text-align:center;padding:5rem 2rem;background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;box-shadow:0 2px 12px rgba(0,0,0,0.06);animation:fadeUp 0.4s ease both;">
    <div style="font-size:3rem;margin-bottom:1rem;opacity:0.3;">📋</div>
    <p style="font-size:1rem;color:#64748b;font-family:'DM Sans',sans-serif;margin:0;">
      No transactions found for this account.
    </p>
  </div>
</c:when>
<c:otherwise>
  <div style="background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;overflow:hidden;box-shadow:0 2px 16px rgba(0,0,0,0.07);animation:fadeUp 0.4s ease both;">
    <table style="width:100%;border-collapse:collapse;">
      <thead>
        <tr>
          <th style="background:#f8fafc;padding:0.9rem 1rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">#</th>
          <th style="background:#f8fafc;padding:0.9rem 1rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Date &amp; Time</th>
          <th style="background:#f8fafc;padding:0.9rem 1rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Type</th>
          <th style="background:#f8fafc;padding:0.9rem 1rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Amount (₹)</th>
          <th style="background:#f8fafc;padding:0.9rem 1rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Balance After (₹)</th>
          <th style="background:#f8fafc;padding:0.9rem 1rem;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;text-align:left;border-bottom:2px solid #e2e8f0;font-family:'DM Sans',sans-serif;">Description</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="txn" items="${transactions}" varStatus="s">
          <tr class="tbl-row">

            <!-- Row Number -->
            <td style="padding:1rem;border-bottom:1px solid #f1f5f9;font-size:0.82rem;color:#94a3b8;font-family:'DM Sans',sans-serif;vertical-align:middle;">
              ${s.count}
            </td>

            <!-- Date & Time -->
            <td style="padding:1rem;border-bottom:1px solid #f1f5f9;font-size:0.85rem;color:#64748b;font-family:'DM Sans',sans-serif;vertical-align:middle;white-space:nowrap;">
              ${txn.transactionDate}
            </td>

            <!-- Transaction Type Badge -->
            <td style="padding:1rem;border-bottom:1px solid #f1f5f9;vertical-align:middle;">
              <c:choose>
                <c:when test="${txn.transactionType.toString().toLowerCase() == 'deposit'}">
                  <span style="display:inline-flex;align-items:center;padding:0.22rem 0.7rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#dcfce7;color:#15803d;border:1px solid #bbf7d0;font-family:'DM Sans',sans-serif;">↓ ${txn.transactionType}</span>
                </c:when>
                <c:when test="${txn.transactionType.toString().toLowerCase() == 'withdrawal'}">
                  <span style="display:inline-flex;align-items:center;padding:0.22rem 0.7rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#fee2e2;color:#b91c1c;border:1px solid #fecaca;font-family:'DM Sans',sans-serif;">↑ ${txn.transactionType}</span>
                </c:when>
                <c:when test="${txn.transactionType.toString().toLowerCase() == 'transfer'}">
                  <span style="display:inline-flex;align-items:center;padding:0.22rem 0.7rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#dbeafe;color:#1d4ed8;border:1px solid #bfdbfe;font-family:'DM Sans',sans-serif;">⇄ ${txn.transactionType}</span>
                </c:when>
                <c:otherwise>
                  <span style="display:inline-flex;align-items:center;padding:0.22rem 0.7rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#f1f5f9;color:#475569;border:1px solid #e2e8f0;font-family:'DM Sans',sans-serif;">${txn.transactionType}</span>
                </c:otherwise>
              </c:choose>
            </td>

            <!-- Amount -->
            <td style="padding:1rem;border-bottom:1px solid #f1f5f9;vertical-align:middle;font-family:'Playfair Display',Georgia,serif;font-size:1rem;font-weight:700;">
              <c:choose>
                <c:when test="${txn.transactionType.toString().toLowerCase() == 'deposit'}">
                  <span style="color:#15803d;">+<fmt:formatNumber value="${txn.amount}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </c:when>
                <c:when test="${txn.transactionType.toString().toLowerCase() == 'withdrawal'}">
                  <span style="color:#b91c1c;">−<fmt:formatNumber value="${txn.amount}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </c:when>
                <c:otherwise>
                  <span style="color:#1d4ed8;"><fmt:formatNumber value="${txn.amount}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                </c:otherwise>
              </c:choose>
            </td>

            <!-- Balance After -->
            <td style="padding:1rem;border-bottom:1px solid #f1f5f9;vertical-align:middle;font-family:'Playfair Display',Georgia,serif;font-size:0.95rem;font-weight:600;color:#475569;">
              <fmt:formatNumber value="${txn.balanceAfter}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
            </td>

            <!-- Description -->
            <td style="padding:1rem;border-bottom:1px solid #f1f5f9;font-size:0.85rem;color:#64748b;font-family:'DM Sans',sans-serif;vertical-align:middle;max-width:220px;">
              ${txn.description}
            </td>

          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- Row count -->
  <p style="text-align:right;margin-top:0.75rem;font-size:0.78rem;color:#94a3b8;font-family:'DM Sans',sans-serif;">
    Showing <c:out value="${transactions.size()}"/> transaction(s)
  </p>
</c:otherwise>
</c:choose>
</div>

<jsp:include page="footer.jsp"/>
