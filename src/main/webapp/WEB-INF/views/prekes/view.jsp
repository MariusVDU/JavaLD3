<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prekės Informacija - ${preke.pavadinimas}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            max-width: 700px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2em;
            margin-bottom: 5px;
        }
        
        .content {
            padding: 40px;
        }
        
        .info-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            border-left: 5px solid #667eea;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #495057;
            font-size: 1em;
        }
        
        .info-value {
            color: #212529;
            font-size: 1.1em;
            text-align: right;
        }
        
        .price {
            font-weight: bold;
            color: #28a745;
            font-size: 1.5em;
        }
        
        .id-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            font-weight: bold;
            font-size: 1.2em;
        }
        
        .stock {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 1.1em;
            font-weight: 600;
        }
        
        .stock-high {
            background: #d4edda;
            color: #155724;
        }
        
        .stock-medium {
            background: #fff3cd;
            color: #856404;
        }
        
        .stock-low {
            background: #f8d7da;
            color: #721c24;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .btn {
            flex: 1;
            min-width: 150px;
            padding: 14px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #000;
        }
        
        .btn-warning:hover {
            background: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        .timestamp {
            font-size: 0.9em;
            color: #6c757d;
            font-style: italic;
        }
        
        .section-title {
            font-size: 1.3em;
            color: #495057;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📦 Prekės Informacija</h1>
            <p>LD2 Prekių Valdymo Sistema</p>
        </div>
        
        <div class="content">
            <h2 class="section-title">Detalės</h2>
            
            <div class="info-card">
                <div class="info-row">
                    <span class="info-label">🆔 Unikalus ID:</span>
                    <span class="info-value"><span class="id-badge">${preke.uniqID}</span></span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">📝 Pavadinimas:</span>
                    <span class="info-value"><strong>${preke.pavadinimas}</strong></span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">💰 Kaina:</span>
                    <span class="info-value price">
                        €<fmt:formatNumber value="${preke.kaina}" minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">📊 Kiekis Sandėlyje:</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${preke.kiekis > 50}">
                                <span class="stock stock-high">${preke.kiekis} vnt.</span>
                            </c:when>
                            <c:when test="${preke.kiekis > 20}">
                                <span class="stock stock-medium">${preke.kiekis} vnt.</span>
                            </c:when>
                            <c:otherwise>
                                <span class="stock stock-low">${preke.kiekis} vnt. ⚠️</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <c:if test="${not empty preke.createdAt}">
                    <div class="info-row">
                        <span class="info-label">🕐 Sukurta:</span>
                        <span class="info-value timestamp">
                            ${preke.createdAt}
                        </span>
                    </div>
                </c:if>
            </div>
            
            <div class="button-group">
                <a href="${pageContext.request.contextPath}/prekes/edit/${preke.uniqID}" 
                   class="btn btn-warning">
                    ✏️ Redaguoti
                </a>
                <form action="${pageContext.request.contextPath}/prekes/delete/${preke.uniqID}" 
                      method="post" style="display: inline; flex: 1;">
                    <button type="submit" class="btn btn-danger" style="width: 100%;"
                            onclick="return confirm('Ar tikrai norite ištrinti prekę: ${preke.pavadinimas}?')">
                        🗑️ Ištrinti
                    </button>
                </form>
            </div>
            
            <div class="button-group" style="margin-top: 15px;">
                <a href="${pageContext.request.contextPath}/prekes" class="btn btn-secondary" style="flex: none; width: 100%;">
                    ⬅️ Grįžti į Sąrašą
                </a>
            </div>
        </div>
    </div>
</body>
</html>
