﻿
Процедура ПриНачалеРаботыСистемы()
		
	СсылкаНаДокумент = ОбщиеФункцииНаКлиенте.ПолучитьДокументНаДатуНаКлиенте(ТекущаяДата());
	
	Если ЗначениеЗаполнено(СсылкаНаДокумент) Тогда
		ПараметрыФормы = Новый Структура("Ключ",СсылкаНаДокумент);
		ОткрытьФорму("Документ.Питание.Форма.ФормаДокумента", ПараметрыФормы);	
	Иначе
		ОткрытьФорму("Документ.Питание.Форма.ФормаДокумента");
	КонецЕсли;
	
КонецПроцедуры
