﻿&НаКлиенте
Процедура ОбновитьГрафик(ДатаНачала, ДатаОкончания)
	
	Если НЕ ЗначениеЗаполнено(ДатаНачала) ИЛИ НЕ ЗначениеЗаполнено(ДатаОкончания) Тогда
		Сообщить("Не заполнен период формирования");
		Возврат;
	КонецЕсли;
	
	График.Обновление = Ложь;
	
	ДанныеДиаграммы = ПолучитьДанные(ДатаНачала, ДатаОкончания);
	
	График.Очистить();
	
	График.Серии.Добавить("Вес");
	
	Для Каждого ТекСтр Из ДанныеДиаграммы Цикл
		Точка = График.УстановитьТочку(Формат(ТекСтр.Период,"ДФ=dd.MM.yy"));
		График.УстановитьЗначение(Точка,График.Серии[0],ТекСтр.Вес);
	КонецЦикла;
	
	График.Обновление = Истина;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьДанные(ДатаНачала, ДатаОкончания)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ДатаНачала",ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания",ДатаОкончания);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ИзмеренияЧеловека.Период КАК Период,
	               |	ИзмеренияЧеловека.Вес КАК Вес
	               |ИЗ
	               |	РегистрСведений.ИзмеренияЧеловека КАК ИзмеренияЧеловека
				   |ГДЕ
				   |	ИзмеренияЧеловека.Период МЕЖДУ &ДатаНачала И &ДатаОкончания
				   |УПОРЯДОЧИТЬ ПО
				   |	ИзмеренияЧеловека.Период";
	
	РЗ = Запрос.Выполнить().Выгрузить();
	
	МассивЗначений = Новый Массив;
	
	Для Каждого ТекСтр Из РЗ Цикл
		СтруктураНабора = Новый Структура("Период,Вес",ТекСтр.Период,ТекСтр.Вес);
		МассивЗначений.Добавить(СтруктураНабора);		
	КонецЦикла;
	
	Возврат МассивЗначений;
		
КонецФункции

&НаКлиенте
Процедура ПериодПриИзменении(Элемент)
	
	ОбновитьГрафик(Период.ДатаНачала,Период.ДатаОкончания);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Период.ДатаНачала = НачалоНедели(ТекущаяДата());
	Период.ДатаОкончания = КонецНедели(ТекущаяДата());
	
	ОбновитьГрафик(Период.ДатаНачала,Период.ДатаОкончания);
	
	ОбновитьТекущийВес();
	
КонецПроцедуры


&НаСервере
Процедура ОбновитьТекущийВес()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ИзмеренияЧеловекаСрезПоследних.Вес КАК Вес
	               |ИЗ
	               |	РегистрСведений.ИзмеренияЧеловека.СрезПоследних(&Период, ) КАК ИзмеренияЧеловекаСрезПоследних";
	
	Запрос.УстановитьПараметр("Период",ТекущаяДата());
	
	РЗ = Запрос.Выполнить().Выгрузить();

	Если РЗ.Количество() Тогда
		ТекущийВес = РЗ.Получить(0).Вес;
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ВнестиИзменения(Команда)
	
	Оповещение = Новый ОписаниеОповещения("ВнестиИзмененияЗавершение",ЭтотОбъект);	
	ОткрытьФорму("РегистрСведений.ИзмеренияЧеловека.ФормаСписка",,ЭтаФорма,,,,Оповещение,РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

&НаКлиенте
Процедура ВнестиИзмененияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	ОбновитьГрафик(Период.ДатаНачала,Период.ДатаОкончания);
	
КонецПроцедуры
