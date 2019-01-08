﻿
&НаКлиенте
Функция СоздатьУведомление(Заголовок, Текст, Данные = 0, ДатаСрабатывания, ИнтервалПовторения = 0)
	
	Уведомление = Новый ДоставляемоеУведомление;
    Уведомление.Заголовок = Заголовок;
    Уведомление.Текст = Текст;
    Уведомление.Данные = Данные;
    Уведомление.ДатаПоявленияУниверсальноеВремя = ДатаСрабатывания;
    Уведомление.ИнтервалПовтора = ИнтервалПовторения;
    Уведомление.ЗвуковоеОповещение = ЗвуковоеОповещение.ПоУмолчанию;
	
    Возврат Уведомление;
	
КонецФункции

&НаКлиенте
Процедура ЗапуститьТаймерВоды(Команда)
	
	#Если МобильноеПриложениеКлиент Тогда
	
		ДатаСрабатывания = УниверсальноеВремя(ТекущаяДата()+5);
		
		Уведомление = СоздатьУведомление("Уведомление", "Выпейте стакан воды", 0, ДатаСрабатывания, ИнтервалПовтора);
	    ДоставляемыеУведомления.ДобавитьЛокальноеУведомление(Уведомление);
		
	#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура ОстановитьТаймер(Команда)
	
	#Если МобильноеПриложениеКлиент Тогда
	
		ДоставляемыеУведомления.ОтменитьЛокальныеУведомления();
		
	#КонецЕсли
	
КонецПроцедуры
