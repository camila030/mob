﻿
Процедура ПересчетИтоговыхРезультатов(ЭтаФорма) Экспорт
	
	ЭтаФорма.Белки = 0;
	ЭтаФорма.Жиры = 0;
	ЭтаФорма.Углеводы = 0;
	ЭтаФорма.ЭнергетическаяЦенность = 0;
	
	Для Каждого Таблица Из ЭтаФорма.НазванияТаблиц Цикл
		
		НазваниеТаблицы = СтрЗаменить(Таблица.Значение,"Таблица","");
		
		Для Каждого ТекСтрока Из ЭтаФорма[Таблица.Значение] Цикл
			
			ЭтаФорма.Белки = ЭтаФорма.Белки + ТекСтрока["Белки"+НазваниеТаблицы];
			ЭтаФорма.Жиры = ЭтаФорма.Жиры + ТекСтрока["Жиры"+НазваниеТаблицы];
			ЭтаФорма.Углеводы = ЭтаФорма.Углеводы + ТекСтрока["Углеводы"+НазваниеТаблицы];
			ЭтаФорма.ЭнергетическаяЦенность = ЭтаФорма.ЭнергетическаяЦенность + ТекСтрока["ПищеваяЦенность"+НазваниеТаблицы];
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ПолучитьДеньНедели(Дата) Экспорт
	
	НомерДня = ДеньНедели(Дата);
	
	Если НомерДня = 1 Тогда
		Возврат "Понедельник";
	ИначеЕсли НомерДня = 2 Тогда
		Возврат "Вторник";
	ИначеЕсли НомерДня = 3 Тогда
		Возврат "Среда";
	ИначеЕсли НомерДня = 4 Тогда
		Возврат "Четверг";
	ИначеЕсли НомерДня = 5 Тогда
		Возврат "Пятница";
	ИначеЕсли НомерДня = 6 Тогда
		Возврат "Суббота";
	ИначеЕсли НомерДня = 7 Тогда
		Возврат "Воскресенье";
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

Функция ПолучитьДокументНаДату(Дата) Экспорт
	
	СсылкаНаДокумент = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	Питание.Ссылка КАК Ссылка
	               |ИЗ
	               |	Документ.Питание КАК Питание
	               |ГДЕ
	               |	Питание.Дата МЕЖДУ &ДатаНачала И &ДатаОкончания";
	
	Запрос.УстановитьПараметр("ДатаНачала",НачалоДня(Дата));
	Запрос.УстановитьПараметр("ДатаОкончания",КонецДня(Дата));
				   
	РЗ = Запрос.Выполнить().Выгрузить();
	
	Если РЗ.Количество() Тогда
		СсылкаНаДокумент = РЗ.Получить(0).Ссылка;
	КонецЕсли;
	
	Возврат СсылкаНаДокумент;
	
КонецФункции

Процедура ПересчетКаллорийности(ЭтаФорма) Экспорт
		
	Для Каждого Таблица Из ЭтаФорма.НазванияТаблиц Цикл
		
		НазваниеТаблицы = СтрЗаменить(Таблица.Значение,"Таблица","");
		
		Для Каждого ТекСтрока Из ЭтаФорма[Таблица.Значение] Цикл
			
			ТекСтрока["Белки"+НазваниеТаблицы] = ТекСтрока["Продукт"+НазваниеТаблицы].Белки * ТекСтрока["Порция"+НазваниеТаблицы]/?(ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность=0,1,ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность);
			ТекСтрока["Жиры"+НазваниеТаблицы] = ТекСтрока["Продукт"+НазваниеТаблицы].Жиры * ТекСтрока["Порция"+НазваниеТаблицы]/?(ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность=0,1,ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность);
			ТекСтрока["Углеводы"+НазваниеТаблицы] = ТекСтрока["Продукт"+НазваниеТаблицы].Углеводы * ТекСтрока["Порция"+НазваниеТаблицы]/?(ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность=0,1,ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность);
			ТекСтрока["ПищеваяЦенность"+НазваниеТаблицы] = ТекСтрока["Продукт"+НазваниеТаблицы].ПищеваяЦенность * ТекСтрока["Порция"+НазваниеТаблицы]/?(ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность=0,1,ТекСтрока["Продукт"+НазваниеТаблицы].ЕдиницаИзмерения.Кратность);
			
		КонецЦикла;
		
	КонецЦикла;
	
	
КонецПроцедуры