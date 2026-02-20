<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp"/>

<c:set var="action" value="${transactionAction}"/>

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
  input:focus {
    border-color: #3b5bdb !important;
    box-shadow: 0 0 0 3px rgba(59,91,219,0.12) !important;
    outline: none !important;
  }
  input::placeholder {
    color: #cbd5e1;
  }
</style>

<!-- Page Header -->
<div style="display:flex;align-items:center;justify-content:space-between;max-width:720px;margin:2.5rem auto 2rem;padding:0 2rem 1.5rem;border-bottom:2px solid #e2e8f0;flex-wrap:wrap;gap:1rem;">
  <div>
    <h1 style="font-family:'Playfair Display',Georgia,serif;font-size:2rem;font-weight:700;color:#1a1e2a;letter-spacing:-0.01em;margin:0 0 6px 0;">
      <c:choose>
        <c:when test="${action == 'deposit'}">💰 Deposit</c:when>
        <c:when test="${action == 'withdraw'}">💸 Withdraw</c:when>
        <c:when test="${action == 'transfer'}">🔄 Fund Transfer</c:when>
      </c:choose>
    </h1>
    <div style="width:40px;height:3px;border-radius:2px;
      <c:choose>
        <c:when test="${action == 'deposit'}">background:#15803d;</c:when>
        <c:when test="${action == 'withdraw'}">background:#c2410c;</c:when>
        <c:otherwise>background:#3b5bdb;</c:otherwise>
      </c:choose>
    "></div>
  </div>
  <a href="${pageContext.request.contextPath}/accounts"
     style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.55rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;box-shadow:0 1px 3px rgba(0,0,0,0.06);"
     onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
     onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
  >← Back</a>
</div>

<!-- Form Card -->
<div style="max-width:720px;margin:0 auto;padding:0 2rem 3rem;">
  <div style="background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;padding:2.5rem;box-shadow:0 2px 16px rgba(0,0,0,0.07);animation:fadeUp 0.4s ease both;">

    <form method="post" action="${pageContext.request.contextPath}/transactions">
      <input type="hidden" name="action" value="${action}"/>

      <c:choose>

        <c:when test="${action == 'deposit' || action == 'withdraw'}">

          <!-- Account Number -->
          <div style="margin-bottom:1.5rem;">
            <label for="accountNumber" style="display:block;font-size:0.78rem;font-weight:700;letter-spacing:0.09em;text-transform:uppercase;color:#64748b;margin-bottom:0.5rem;font-family:'DM Sans',sans-serif;">
              Account Number <span style="color:#b91c1c;">*</span>
            </label>
            <input type="text" id="accountNumber" name="accountNumber"
                   value="${prefillAccount}" required
                   placeholder="e.g. ACC1001"
                   style="width:100%;background:#f8fafc;border:1px solid #e2e8f0;border-radius:8px;padding:0.7rem 1rem;font-family:'DM Sans',sans-serif;font-size:0.95rem;color:#1e293b;box-sizing:border-box;transition:border-color 0.2s,box-shadow 0.2s;"/>
          </div>

          <!-- Amount -->
          <div style="margin-bottom:1.5rem;">
            <label for="amount" style="display:block;font-size:0.78rem;font-weight:700;letter-spacing:0.09em;text-transform:uppercase;color:#64748b;margin-bottom:0.5rem;font-family:'DM Sans',sans-serif;">
              Amount (₹) <span style="color:#b91c1c;">*</span>
            </label>
            <input type="number" id="amount" name="amount"
                   min="1" step="0.01" required
                   placeholder="Enter amount"
                   style="width:100%;background:#f8fafc;border:1px solid #e2e8f0;border-radius:8px;padding:0.7rem 1rem;font-family:'DM Sans',sans-serif;font-size:0.95rem;color:#1e293b;box-sizing:border-box;transition:border-color 0.2s,box-shadow 0.2s;"/>
          </div>

        </c:when>

        <c:when test="${action == 'transfer'}">

          <!-- From Account -->
          <div style="margin-bottom:1.5rem;">
            <label for="fromAccount" style="display:block;font-size:0.78rem;font-weight:700;letter-spacing:0.09em;text-transform:uppercase;color:#64748b;margin-bottom:0.5rem;font-family:'DM Sans',sans-serif;">
              From Account <span style="color:#b91c1c;">*</span>
            </label>
            <input type="text" id="fromAccount" name="fromAccount"
                   required placeholder="Source account number"
                   style="width:100%;background:#f8fafc;border:1px solid #e2e8f0;border-radius:8px;padding:0.7rem 1rem;font-family:'DM Sans',sans-serif;font-size:0.95rem;color:#1e293b;box-sizing:border-box;transition:border-color 0.2s,box-shadow 0.2s;"/>
          </div>

          <!-- To Account -->
          <div style="margin-bottom:1.5rem;">
            <label for="toAccount" style="display:block;font-size:0.78rem;font-weight:700;letter-spacing:0.09em;text-transform:uppercase;color:#64748b;margin-bottom:0.5rem;font-family:'DM Sans',sans-serif;">
              To Account <span style="color:#b91c1c;">*</span>
            </label>
            <input type="text" id="toAccount" name="toAccount"
                   required placeholder="Destination account number"
                   style="width:100%;background:#f8fafc;border:1px solid #e2e8f0;border-radius:8px;padding:0.7rem 1rem;font-family:'DM Sans',sans-serif;font-size:0.95rem;color:#1e293b;box-sizing:border-box;transition:border-color 0.2s,box-shadow 0.2s;"/>
          </div>

          <!-- Amount -->
          <div style="margin-bottom:1.5rem;">
            <label for="amount" style="display:block;font-size:0.78rem;font-weight:700;letter-spacing:0.09em;text-transform:uppercase;color:#64748b;margin-bottom:0.5rem;font-family:'DM Sans',sans-serif;">
              Amount (₹) <span style="color:#b91c1c;">*</span>
            </label>
            <input type="number" id="amount" name="amount"
                   min="1" step="0.01" required placeholder="Enter amount"
                   style="width:100%;background:#f8fafc;border:1px solid #e2e8f0;border-radius:8px;padding:0.7rem 1rem;font-family:'DM Sans',sans-serif;font-size:0.95rem;color:#1e293b;box-sizing:border-box;transition:border-color 0.2s,box-shadow 0.2s;"/>
          </div>

        </c:when>

      </c:choose>

      <!-- Divider -->
      <div style="height:1px;background:#f1f5f9;margin:2rem 0 1.8rem;"></div>

      <!-- Form Actions -->
      <div style="display:flex;align-items:center;gap:0.75rem;flex-wrap:wrap;">
        <button type="submit"
          style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.6rem 1.5rem;background:#3b5bdb;color:#ffffff;border:none;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.9rem;font-weight:600;cursor:pointer;letter-spacing:0.02em;box-shadow:0 2px 6px rgba(59,91,219,0.25);"
          onmouseover="this.style.background='#2f4ac7';this.style.boxShadow='0 4px 14px rgba(59,91,219,0.35)'"
          onmouseout="this.style.background='#3b5bdb';this.style.boxShadow='0 2px 6px rgba(59,91,219,0.25)'"
        >Confirm</button>

        <a href="${pageContext.request.contextPath}/accounts"
           style="display:inline-flex;align-items:center;gap:0.4rem;padding:0.6rem 1.2rem;background:#ffffff;color:#475569;border:1px solid #e2e8f0;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.875rem;font-weight:500;text-decoration:none;"
           onmouseover="this.style.background='#f1f5f9';this.style.color='#1e293b'"
           onmouseout="this.style.background='#ffffff';this.style.color='#475569'"
        >Cancel</a>
      </div>

    </form>
  </div>
</div>

<jsp:include page="footer.jsp"/>
