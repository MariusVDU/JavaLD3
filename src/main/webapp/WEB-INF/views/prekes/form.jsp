<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Redaguoti Prekę' : 'Nauja Prekė'} - LD2 Sistema</title>
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
            max-width: 600px;
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
            margin-bottom: 10px;
        }
        
        .content {
            padding: 40px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 1em;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .form-group input[type="number"] {
            -moz-appearance: textfield;
        }
        
        .form-group input[type="number"]::-webkit-outer-spin-button,
        .form-group input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        
        .required {
            color: #dc3545;
            margin-left: 3px;
        }
        
        .helper-text {
            font-size: 0.85em;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
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
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
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
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .input-group {
            display: flex;
            gap: 15px;
        }
        
        .input-group .form-group {
            flex: 1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>${isEdit ? '✏️ Redaguoti Prekę' : '➕ Nauja Prekė'}</h1>
            <p>LD2 Prekių Valdymo Sistema</p>
        </div>
        
        <div class="content">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    ❌ ${errorMessage}
                </div>
            </c:if>
            
            <form action="${isEdit ? pageContext.request.contextPath.concat('/prekes/').concat(preke.uniqID) : pageContext.request.contextPath.concat('/prekes')}" 
                  method="post">
                
                <div class="form-group">
                    <label for="uniqID">
                        Unikalus ID <span class="required">*</span>
                    </label>
                    <input type="number" 
                           id="uniqID" 
                           name="uniqID" 
                           value="${preke.uniqID}" 
                           ${isEdit ? 'readonly' : 'required'}
                           placeholder="Pvz.: 00251">
                    <div class="helper-text">
                        ${isEdit ? 'ID negali būti keičiamas' : 'Įveskite unikalų prekės numerį'}
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="pavadinimas">
                        Pavadinimas <span class="required">*</span>
                    </label>
                    <input type="text" 
                           id="pavadinimas" 
                           name="pavadinimas" 
                           value="${preke.pavadinimas}" 
                           required
                           placeholder="Pvz.: Obuolys">
                    <div class="helper-text">Įveskite prekės pavadinimą</div>
                </div>
                
                <div class="input-group">
                    <div class="form-group">
                        <label for="kaina">
                            Kaina (€) <span class="required">*</span>
                        </label>
                        <input type="number" 
                               id="kaina" 
                               name="kaina" 
                               value="${preke.kaina}" 
                               step="0.01" 
                               min="0"
                               required
                               placeholder="0.00">
                        <div class="helper-text">Kaina eurais</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="kiekis">
                            Kiekis (vnt.) <span class="required">*</span>
                        </label>
                        <input type="number" 
                               id="kiekis" 
                               name="kiekis" 
                               value="${preke.kiekis}" 
                               min="0"
                               required
                               placeholder="0">
                        <div class="helper-text">Sandėlyje</div>
                    </div>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">
                        ${isEdit ? '💾 Išsaugoti Pakeitimus' : '➕ Sukurti Prekę'}
                    </button>
                    <a href="${pageContext.request.contextPath}/prekes" class="btn btn-secondary">
                        ❌ Atšaukti
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
