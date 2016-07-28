/**
 * Created by yuanzhe on 2016/7/12.
 * 这个javascript文件主要是作为发票页面的验证使用。
 */
var Utils = window.Utils || new Object();
;(function($){
    $.validate = {
        validateTaxRateEqualsZero : function(dataCell) {
            var returnValue = false;
            Utils.common.forEachDataCell(dataCell, function(entity){
                var amount = entity.getValue("amount");//明细金额
                var vat_rate = entity.getProperty("vat_rate");
                if (!amount || !vat_rate || (parseFloat(vat_rate) <= 0 && parseFloat(amount) > 0)) {
                    returnValue = true;
                }
            });
            return returnValue;
        },
        hasNegativeNumber : function(dataCell) {
            var returnValue = false;
            Utils.common.forEachDataCell(dataCell, function(entity){
                var amount_item = entity.getValue("amount");//明细金额
                if (amount_item === null || amount_item === "" || amount_item === "null" || parseFloat(amount_item) <= -1) {
                    returnValue = true;
                }
            });
            return returnValue;
        },
        hasGeneralTaxpayer : function(dataCell){
            var returnValue = false;
            Utils.common.forEachDataCell(dataCell, function(entity){
                var invoice_type = entity.getProperty("is_payticket_for_delegate");
                var amount = entity.getProperty('amount');
                if (!(!!invoice_type && '0' === invoice_type && !!amount && parseFloat(amount) >= 1)) {
                    returnValue = true;
                }
            });
            return returnValue;
        },
        hasProInvoiceInNonGeneralTaxpayer : function(dataCell) {
            var returnValue = false;
            Utils.common.forEachDataCell(dataCell, function(entity){
                var invoice_type = entity.getProperty("is_payticket_for_delegate");
                if (!(!!invoice_type && '0' === invoice_type)) {
                    returnValue = true;
                }
            });
            return returnValue;
        },
        hasDSFApplyProfessInvoice : function(dataCell, is_display_year_month) {
            var returnValue = false;
            Utils.common.forEachDataCell(dataCell, function(entity){
                var fin_subjects_bd;
                if ("0" === is_display_year_month || !is_display_year_month) {
                    fin_subjects_bd = entity.getProperty("fin_small_subjects_bd");
                } else {
                    fin_subjects_bd = entity.getProperty("fin_subjects_bd");
                }
                var invoice_type = entity.getProperty("is_payticket_for_delegate");
                if ((!!invoice_type && '1' === invoice_type) && ("'1','3','4','5','6','7','10','14".indexOf("'"+fin_subjects_bd+"'") >= 0)) {
                    returnValue = true;
                }
            });
            return returnValue;
        }
    };
    $.common = {
        forEachDataCell : function(dataCell, callback) {
            var count = dataCell.dataset.values.length;//当前已经存在的记录数
            for (var i = 0; i < count; i++) {
                var entity = dataCell.dataset.get(i);
                callback.call(this, entity);
            }
        },
        invoiceRound : function(value){
            return parseFloat(parseFloat(value).toFixed(2));
        },
        getTotalAmount : function(dataCell) {
            var total_amount = 0.00;
            Utils.common.forEachDataCell(dataCell, function(entity){
                total_amount += Utils.common.getEntityTotalAmount(entity);
            });
            return Utils.common.invoiceRound(total_amount);
        },
        backOldAmount : function(dataCell) {
            Utils.common.forEachDataCell(dataCell, function(entity){
                var amount = entity.getProperty("amount_old");
                var vat_rate = entity.getProperty("vat_rate");
                entity.setProperty("amount", amount);
                entity.setProperty("vat_mount", Utils.common.invoiceRound(parseFloat(amount) * parseFloat(vat_rate)) || "0.00");
                entity.setProperty("totalAmount", Utils.common.getEntityTotalAmount(entity));
            });
            var total_amount = parseFloat($id("static_invoice_amount").value);
            if (!$id("small_amount").disabled) {
                total_amount += parseFloat($id("small_amount").value);
            }
            $id("total_invoice_amount").innerText = Utils.common.invoiceRound(total_amount);
        },
        getEntityTotalAmount : function(entity) {
            var amount = entity.getProperty("amount");
            var vat_amount = entity.getProperty("vat_mount");
            if (!!amount) {
                amount = Utils.common.invoiceRound(amount);
            } else {
                amount = 0.00;
                entity.setProperty("amount", amount);
                entity.setProperty("amount_old", amount);
            }
            if (!!vat_amount) {
                vat_amount = parseFloat(vat_amount);
            } else {
                vat_amount = 0.00;
                entity.setProperty("vat_mount", vat_amount);
            }
            return amount + vat_amount;
        },
        statAllEntityTotalAmount : function(dataCell) {
            Utils.common.forEachDataCell(dataCell, function(entity){
                entity.setProperty("totalAmount", Utils.common.getEntityTotalAmount(entity));
            });
        },
        isFloat : function (target) {
            var rc = true;
            if (!!target) {
                var oneDecimal = false;
                for (var i = 0; i < target.length; i++) {
                    var ch = target.charAt(i);
                    if (i == 0 && ch == '-') {
                        continue;
                    }
                    if (ch == "." && !oneDecimal) {
                        oneDecimal = true;
                        continue;
                    }
                    if (ch == ",") {
                        continue;
                    }
                    if ((ch < "0") || (ch > '9')) {
                        rc = false;
                        break;
                    }
                }
            } else {
                rc = false;
            }
            return rc;
        }
    };
})(Utils);