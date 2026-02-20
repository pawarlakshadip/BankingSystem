<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Smart Banking System</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500;600&display=swap');

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background-color: #f4f6f9;
      color: #1a1e2a;
      font-family: 'DM Sans', sans-serif;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    @keyframes slideDown {
      from { opacity: 0; transform: translateY(-8px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .nav-link {
      color: #475569;
      text-decoration: none;
      font-size: 0.875rem;
      font-weight: 500;
      letter-spacing: 0.02em;
      padding: 0.4rem 0.85rem;
      border-radius: 6px;
      transition: color 0.2s, background 0.2s;
      font-family: 'DM Sans', sans-serif;
    }
    .nav-link:hover {
      color: #1e293b;
      background: #e2e8f0;
    }
  </style>
</head>

<body>

<!-- Navbar -->
<nav style="
  background: #ffffff;
  border-bottom: 1px solid #e2e8f0;
  position: sticky;
  top: 0;
  z-index: 100;
  padding: 0 2rem;
  box-shadow: 0 1px 6px rgba(0,0,0,0.06);
">
  <div style="
    max-width: 1100px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 64px;
  ">

    <!-- Brand -->
    <div style="
      font-family: 'Playfair Display', Georgia, serif;
      font-size: 1.3rem;
      font-weight: 700;
      color: #3b5bdb;
      letter-spacing: 0.01em;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    ">
      🏦 Smart Banking
    </div>

    <!-- Nav Links -->
    <ul style="list-style:none;display:flex;align-items:center;gap:0.25rem;margin:0;padding:0;">
      <li><a href="${pageContext.request.contextPath}/accounts" class="nav-link">All Accounts</a></li>
      <li><a href="${pageContext.request.contextPath}/accounts?action=new" class="nav-link">Open Account</a></li>
      <li><a href="${pageContext.request.contextPath}/transactions?action=deposit" class="nav-link">Deposit</a></li>
      <li><a href="${pageContext.request.contextPath}/transactions?action=withdraw" class="nav-link">Withdraw</a></li>
      <li>
        <a href="${pageContext.request.contextPath}/transactions?action=transfer" style="
          display: inline-flex;
          align-items: center;
          padding: 0.4rem 0.9rem;
          background: #eff2ff;
          color: #3b5bdb;
          border: 1px solid #c5d0fc;
          border-radius: 6px;
          font-size: 0.875rem;
          font-weight: 600;
          text-decoration: none;
          font-family: 'DM Sans', sans-serif;
          margin-left: 0.25rem;
          transition: background 0.2s;
        "
        onmouseover="this.style.background='#dbe4ff'"
        onmouseout="this.style.background='#eff2ff'"
        >Transfer</a>
      </li>
    </ul>

  </div>
</nav>

<!-- Container -->
<div style="flex: 1;">

  <!-- Flash Messages -->
  <div style="max-width:1100px;margin:0 auto;padding:0 2rem;">

    <c:if test="${not empty sessionScope.successMessage}">
      <div style="
        padding: 0.9rem 1.2rem;
        border-radius: 8px;
        font-size: 0.9rem;
        margin-top: 1.5rem;
        background: #dcfce7;
        color: #15803d;
        border: 1px solid #bbf7d0;
        font-family: 'DM Sans', sans-serif;
        animation: slideDown 0.3s ease both;
        display: flex;
        align-items: center;
        gap: 0.6rem;
        box-shadow: 0 1px 4px rgba(21,128,61,0.1);
      ">
        ✓ ${sessionScope.successMessage}
      </div>
      <c:remove var="successMessage" scope="session"/>
    </c:if>

    <c:if test="${not empty requestScope.error}">
      <div style="
        padding: 0.9rem 1.2rem;
        border-radius: 8px;
        font-size: 0.9rem;
        margin-top: 1.5rem;
        background: #fee2e2;
        color: #b91c1c;
        border: 1px solid #fecaca;
        font-family: 'DM Sans', sans-serif;
        animation: slideDown 0.3s ease both;
        display: flex;
        align-items: center;
        gap: 0.6rem;
        box-shadow: 0 1px 4px rgba(185,28,28,0.1);
      ">
        ✕ ${requestScope.error}
      </div>
    </c:if>

  </div>
