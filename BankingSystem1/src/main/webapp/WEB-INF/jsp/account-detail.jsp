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
  .detail-item:hover {
    background: #f0f4ff !important;
  }
</style>

<!-- Page Header -->
<div style="display:flex;align-items:center;justify-content:space-between;max-width:1100px;margin:2.5rem auto 2rem;padding:0 2rem 1.5rem;border-bottom:2px solid #e2e8f0;flex-wrap:wrap;gap:1rem;">
  <div>
    <h1 style="font-family:'Playfair Display',Georgia,serif;font-size:2rem;font-weight:700;color:#1a1e2a;letter-spacing:-0.01em;margin:0 0 6px 0;">Account Details</h1>
    <div style="width:40px;height:3px;background:#3b5bdb;border-radius:2px;"></div>
  </div>
  <a href="${pageContext.request.contextPath}/accounts"
     style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;box-shadow:0 1px 3px rgba(0,0,0,0.06);"
     onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
     onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
  >← Back</a>
</div>

<!-- Detail Card -->
<div style="max-width:1100px;margin:0 auto;padding:0 2rem 3rem;">
  <div style="background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;overflow:hidden;box-shadow:0 2px 16px rgba(0,0,0,0.07);animation:fadeUp 0.4s ease both;">

    <!-- Detail Grid -->
    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));">

      <!-- Account Number -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Account Number</label>
        <span><strong style="font-family:'Playfair Display',Georgia,serif;font-size:1.05rem;color:#3b5bdb;font-weight:700;letter-spacing:0.03em;">${account.accountNumber}</strong></span>
      </div>

      <!-- Account Type -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Account Type</label>
        <c:choose>
          <c:when test="${account.accountTypeName.toLowerCase() == 'savings'}">
            <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#dbeafe;color:#1d4ed8;border:1px solid #bfdbfe;font-family:'DM Sans',sans-serif;">${account.accountTypeName}</span>
          </c:when>
          <c:when test="${account.accountTypeName.toLowerCase() == 'current'}">
            <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#ffedd5;color:#c2410c;border:1px solid #fed7aa;font-family:'DM Sans',sans-serif;">${account.accountTypeName}</span>
          </c:when>
          <c:otherwise>
            <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#fef9c3;color:#a16207;border:1px solid #fde68a;font-family:'DM Sans',sans-serif;">${account.accountTypeName}</span>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Holder Name -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Holder Name</label>
        <span style="font-size:1rem;color:#1e293b;font-family:'DM Sans',sans-serif;font-weight:500;">${account.holderName}</span>
      </div>

      <!-- Email -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Email</label>
        <span style="font-size:1rem;color:#1e293b;font-family:'DM Sans',sans-serif;">${account.email}</span>
      </div>

      <!-- Phone -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Phone</label>
        <span style="font-size:1rem;color:#1e293b;font-family:'DM Sans',sans-serif;">${account.phone}</span>
      </div>

      <!-- Balance -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Balance</label>
        <span style="font-family:'Playfair Display',Georgia,serif;font-size:1.6rem;font-weight:700;color:#15803d;letter-spacing:-0.01em;">
          ₹<fmt:formatNumber value="${account.balance}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
        </span>
      </div>

      <!-- Interest Rate -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Interest Rate</label>
        <span style="font-size:1rem;color:#1e293b;font-family:'DM Sans',sans-serif;">${account.interestRate}% p.a.</span>
      </div>

      <!-- Minimum Balance -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Minimum Balance</label>
        <span style="font-size:1rem;color:#1e293b;font-family:'DM Sans',sans-serif;">
          ₹<fmt:formatNumber value="${account.minimumBalance}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
        </span>
      </div>

      <!-- Status -->
      <div class="detail-item" style="padding:1.4rem 1.8rem;border-bottom:1px solid #f1f5f9;border-right:1px solid #f1f5f9;transition:background 0.2s;">
        <label style="display:block;font-size:0.72rem;font-weight:700;letter-spacing:0.1em;text-transform:uppercase;color:#94a3b8;margin-bottom:0.45rem;font-family:'DM Sans',sans-serif;">Status</label>
        <c:choose>
          <c:when test="${account.active}">
            <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#dcfce7;color:#15803d;border:1px solid #bbf7d0;font-family:'DM Sans',sans-serif;">Active</span>
          </c:when>
          <c:otherwise>
            <span style="display:inline-flex;align-items:center;padding:0.25rem 0.75rem;border-radius:999px;font-size:0.75rem;font-weight:600;letter-spacing:0.05em;text-transform:uppercase;background:#fee2e2;color:#b91c1c;border:1px solid #fecaca;font-family:'DM Sans',sans-serif;">Closed</span>
          </c:otherwise>
        </c:choose>
      </div>

    </div><!-- /detail-grid -->

    <!-- Action Bar -->
    <c:if test="${account.active}">
      <div style="display:flex;flex-wrap:wrap;gap:0.75rem;padding:1.5rem 1.8rem;background:#f8fafc;border-top:2px solid #e2e8f0;align-items:center;">

        <a href="${pageContext.request.contextPath}/transactions?action=deposit&accountNumber=${account.accountNumber}"
           style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#3b5bdb;color:#ffffff;border:1px solid #3b5bdb;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:600;text-decoration:none;box-shadow:0 2px 6px rgba(59,91,219,0.25);"
           onmouseover="this.style.background='#2f4ac7'"
           onmouseout="this.style.background='#3b5bdb'"
        >💰 Deposit</a>

        <a href="${pageContext.request.contextPath}/transactions?action=withdraw&accountNumber=${account.accountNumber}"
           style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#fff7ed;color:#c2410c;border:1px solid #fed7aa;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;"
           onmouseover="this.style.background='#ffedd5'"
           onmouseout="this.style.background='#fff7ed'"
        >💸 Withdraw</a>

        <a href="${pageContext.request.contextPath}/transactions?action=transfer&accountNumber=${account.accountNumber}"
           style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;"
           onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
           onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
        >🔄 Transfer</a>

        <a href="${pageContext.request.contextPath}/transactions?action=history&accountNumber=${account.accountNumber}"
           style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;"
           onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
           onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
        >📋 Full History</a>

        <a href="${pageContext.request.contextPath}/transactions?action=mini&accountNumber=${account.accountNumber}"
           style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;"
           onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
           onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
        >📄 Mini Statement</a>

        <a href="${pageContext.request.contextPath}/accounts?action=edit&accountNumber=${account.accountNumber}"
           style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;"
           onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
           onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
        >✏️ Edit</a>

        <form method="post" action="${pageContext.request.contextPath}/accounts"
              style="display:inline-flex;"
              onsubmit="return confirm('Are you sure you want to close this account? Remaining balance will be refunded.')">
          <input type="hidden" name="action" value="close"/>
          <input type="hidden" name="accountNumber" value="${account.accountNumber}"/>
          <button type="submit"
            style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#fff1f2;color:#b91c1c;border:1px solid #fecaca;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;cursor:pointer;"
            onmouseover="this.style.background='#fee2e2'"
            onmouseout="this.style.background='#fff1f2'"
          >🔒 Close Account</button>
        </form>

      </div>
    </c:if>

  </div>
</div>

<jsp:include page="footer.jsp"/>
