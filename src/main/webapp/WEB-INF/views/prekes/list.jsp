<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prekių Sąrašas - LD2 Prekių Valdymo Sistema</title>
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
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
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
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        
        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }
        
        .content {
            padding: 30px;
        }
        
        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            animation: slideDown 0.3s ease-out;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-info {
            background: #17a2b8;
            color: white;
        }
        
        .btn-info:hover {
            background: #138496;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background: #ffc107;
            color: #000;
        }
        
        .btn-warning:hover {
            background: #e0a800;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
            letter-spacing: 0.5px;
        }
        
        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        
        tbody tr {
            transition: all 0.3s ease;
        }
        
        tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .action-buttons .btn {
            padding: 8px 16px;
            font-size: 0.9em;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .stat-card h3 {
            font-size: 2em;
            margin-bottom: 5px;
        }
        
        .stat-card p {
            font-size: 0.9em;
            opacity: 0.9;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .search-form input {
            flex: 1;
            min-width: 200px;
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
        }
        
        .search-form input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        
        .empty-state h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
        }
        
        .price {
            font-weight: bold;
            color: #28a745;
        }
        
        .stock {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🛒 Prekių Valdymo Sistema</h1>
            <p>LD2 Laboratorinis Darbas - Marius Steponavičius</p>
        </div>
        
        <div class="content">
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    ✅ ${successMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    ❌ ${errorMessage}
                </div>
            </c:if>
            
            <!-- Statistics -->
            <div class="stats">
                <div class="stat-card">
                    <h3>${prekes.size()}</h3>
                    <p>Prekių Iš Viso</p>
                </div>
            </div>
            
            <!-- Actions -->
            <div class="actions">
                <a href="${pageContext.request.contextPath}/prekes/new" class="btn btn-primary">
                    ➕ Pridėti Naują Prekę
                </a>
                <a href="${pageContext.request.contextPath}/prekes/low-stock" class="btn btn-warning">
                    ⚠️ Žemas Kiekis
                </a>
            </div>
            
            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/prekes/search" method="get" class="search-form">
                <input type="text" name="pavadinimas" placeholder="🔍 Ieškoti pagal pavadinimą...">
                <button type="submit" class="btn btn-secondary">Ieškoti</button>
                <a href="${pageContext.request.contextPath}/prekes" class="btn btn-secondary">Rodyti Visas</a>
            </form>
            
            <!-- Prekes Table -->
            <c:choose>
                <c:when test="${empty prekes}">
                    <div class="empty-state">
                        <h3>📦 Prekių nerasta</h3>
                        <p>Pradėkite pridėdami naują prekę</p>
                        <a href="${pageContext.request.contextPath}/prekes/new" class="btn btn-primary" style="margin-top: 20px;">
                            ➕ Pridėti Pirmą Prekę
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Pavadinimas</th>
                                <th>Kaina</th>
                                <th>Kiekis</th>
                                <th>Veiksmai</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${prekes}" var="preke">
                                <tr>
                                    <td><strong>${preke.uniqID}</strong></td>
                                    <td>${preke.pavadinimas}</td>
                                    <td class="price">€<fmt:formatNumber value="${preke.kaina}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${preke.kiekis > 50}">
                                                <span class="stock stock-high">${preke.kiekis} vnt.</span>
                                            </c:when>
                                            <c:when test="${preke.kiekis > 20}">
                                                <span class="stock stock-medium">${preke.kiekis} vnt.</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock stock-low">${preke.kiekis} vnt.</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/prekes/view/${preke.uniqID}" 
                                               class="btn btn-info">👁️ Žiūrėti</a>
                                            <a href="${pageContext.request.contextPath}/prekes/edit/${preke.uniqID}" 
                                               class="btn btn-warning">✏️ Redaguoti</a>
                                            <form action="${pageContext.request.contextPath}/prekes/delete/${preke.uniqID}" 
                                                  method="post" style="display: inline;">
                                                <button type="submit" class="btn btn-danger" 
                                                        onclick="return confirm('Ar tikrai norite ištrinti prekę: ${preke.pavadinimas}?')">
                                                    🗑️ Ištrinti
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
