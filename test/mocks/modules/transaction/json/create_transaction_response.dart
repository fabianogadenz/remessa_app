final Map<String, dynamic> jsonResponse = {
  "id": 965829,
  "createdAt": "2020-12-11T14:05:55.067Z",
  "updatedAt": "2020-12-11T14:05:55.209Z",
  "flow": "OUTBOUND",
  "transactionName": "Envio para Henrique Cadioli (2)",
  "purpose": "Disponibilidade no exterior",
  "analysisLevel": 1,
  "quote": {
    "foreignCurrency": "CAD",
    "foreignCurrencyAmount": 55.71,
    "nationalCurrency": "BRL",
    "nationalCurrencyTotalAmount": 300,
    "nationalCurrencySubAmount": 228.91,
    "exchangeRate": 4.108957,
    "vet": 5.38503,
    "originalVet": 5.489327217125383,
    "totalTaxes": 71.09,
    "feeTaxes": [
      {
        "label": "Tarifa bancária",
        "description":
            "Tarifa de utilização do sistema bancário para transferências internacionais.",
        "value": 71.09
      }
    ],
    "spread": 0,
    "originalSpread": 1.9,
    "tradingQuotation": 4.108957,
    "voucherCode": null,
    "voucherDiscount": null,
    "spreadDiscount": null,
    "costDescription": null
  },
  "counterpart": {
    "name": "Henrique Cadioli",
    "country": "Estados Unidos",
    "bankName": "Bank of America, National Association",
    "historyId": 162820,
    "redirectUrl":
        "http://localhost:4000/app/nova-operacao-beneficiario/162820",
    "accountInfo": [
      {
        "label": "ABA Routing Number",
        "description":
            "A função do ABA Routing Number é identificar agências bancárias dentro dos EUA.",
        "value": ""
      },
      {
        "label": "Código SWIFT/BIC",
        "description":
            "O código SWIFT é um número único e atua como um identificador de instituições financeiras, sem este número não é possível realizar a transação.",
        "value": "bofaus3n"
      },
      {
        "label": "Número da conta",
        "description":
            "É o número que identifica a conta do beneficiário no exterior.",
        "value": "11111111"
      },
      {"label": "ACH Routing Number", "value": "121140713"}
    ],
    "intermediaryBankInfo": []
  },
  "arrivalEstimate": "1 dia útil",
  "paymentDeadline": "2020-12-11T16:00:00.000Z",
  "statusName": "Iniciada",
  "statusId": 1
};
