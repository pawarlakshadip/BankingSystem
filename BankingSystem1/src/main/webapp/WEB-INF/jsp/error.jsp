<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
</style>

<div style="
  max-width: 600px;
  margin: 5rem auto;
  padding: 0 2rem;
  text-align: center;
  animation: fadeUp 0.4s ease both;
">
  <div style="
    background: #ffffff;
    border: 1px solid #fecaca;
    border-top: 4px solid #ef4444;
    border-radius: 12px;
    padding: 3rem 2.5rem;
    box-shadow: 0 4px 20px rgba(239,68,68,0.08);
  ">

    <!-- Icon -->
    <div style="font-size: 3.5rem; margin-bottom: 1.2rem;">⚠️</div>

    <!-- Title -->
    <h1 style="
      font-family: 'Playfair Display', Georgia, serif;
      font-size: 1.8rem;
      font-weight: 700;
      color: #b91c1c;
      letter-spacing: -0.01em;
      margin: 0 0 1rem 0;
    ">Something went wrong</h1>

    <!-- Error Message -->
    <p style="
      font-size: 1rem;
      color: #64748b;
      font-family: 'DM Sans', sans-serif;
      background: #fff1f2;
      border: 1px solid #fecaca;
      border-radius: 8px;
      padding: 0.85rem 1.2rem;
      margin: 0 0 2rem 0;
      line-height: 1.6;
    ">
      ${not empty error ? error : 'An unexpected error occurred.'}
    </p>

    <!-- Button -->
    <a href="${pageContext.request.contextPath}/accounts"
       style="
         display: inline-flex;
         align-items: center;
         gap: 0.4rem;
         padding: 0.65rem 1.6rem;
         background: #3b5bdb;
         color: #ffffff;
         border: none;
         border-radius: 8px;
         font-family: 'DM Sans', sans-serif;
         font-size: 0.9rem;
         font-weight: 600;
         text-decoration: none;
         box-shadow: 0 2px 8px rgba(59,91,219,0.25);
         letter-spacing: 0.02em;
       "
       onmouseover="this.style.background='#2f4ac7';this.style.boxShadow='0 4px 14px rgba(59,91,219,0.35)'"
       onmouseout="this.style.background='#3b5bdb';this.style.boxShadow='0 2px 8px rgba(59,91,219,0.25)'"
    >Go to Accounts</a>

  </div>
</div>

<jsp:include page="footer.jsp"/>
