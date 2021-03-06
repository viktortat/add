﻿
// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Утилита);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "УтвержденияПроверкаТаблиц");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры
// } Plugin interface

Процедура ПроверитьРавенствоТаблиц(Таб1, Таб2, ДопСообщениеОшибки = "") Экспорт
	
	Если ТипЗнч(Таб1) <> Тип("ТаблицаЗначений") Тогда
		ВызватьИсключение "ПроверитьРавенствоТаблиц: Первый параметр-таблица таблицей не является";
	КонецЕсли;
	Если ТипЗнч(Таб2) <> Тип("ТаблицаЗначений") Тогда
		ВызватьИсключение "ПроверитьРавенствоТаблиц: Второй параметр-таблица таблицей не является";
	КонецЕсли;
	
	Различия = Новый ТаблицаЗначений;
	РезультатСравнения = СравнитьТаблицы(Таб1, Таб2, Различия);
	
	Если РезультатыСравненияТаблиц.ТаблицыСовпадают <> РезультатСравнения Тогда
		
		ИменаРезультатов = Новый Соответствие;
		Для Каждого КлючЗначение Из РезультатыСравненияТаблиц Цикл
			ИменаРезультатов.Вставить(КлючЗначение.Значение, КлючЗначение.Ключ);
		КонецЦикла; 
		СтрокаОшибок = "Различия в таблицах:" + Символы.ПС;
		СтрокаОшибок = СтрокаОшибок + "Ожидали статус <" + ИменаРезультатов[РезультатыСравненияТаблиц.ТаблицыСовпадают] + ">, а получили <" + ИменаРезультатов[РезультатСравнения] + ">" + Символы.ПС;
		Для Каждого Строка Из Различия Цикл
			СтрокаОшибок = СтрокаОшибок + "Значение [" + Строка.Колонка + ":" + Строка.Строка + "]. Ожидали <" + Строка.Ожидание + ">, а получили <" + Строка.Результат + ">" + Символы.ПС;
		КонецЦикла;
		
		ВызватьОшибкуПроверки("Таблицы должны совпадать, а они различны" + Символы.ПС + СтрокаОшибок + Символы.ПС + ДопСообщениеОшибки);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьРавенствоТабличныхДокументовТолькоПоЗначениям(ТабДок1, ТабДок2, УчитыватьТолькоВидимыеКолонкиИлиДопСообщениеОшибки = Ложь, УчитыватьТолькоВидимыеСтрокиИлиДопСообщениеОшибки = Ложь, Знач ДопСообщениеОшибки = "") Экспорт
	
	Если ТипЗнч(ТабДок1) <> Тип("ТабличныйДокумент") Тогда
		ВызватьИсключение "ПроверитьРавенствоТабличныхДокументовТолькоПоЗначениям: Первый параметр-таблица не является табличным документов";
	КонецЕсли;
	Если ТипЗнч(ТабДок2) <> Тип("ТабличныйДокумент") Тогда
		ВызватьИсключение "ПроверитьРавенствоТабличныхДокументовТолькоПоЗначениям: Второй параметр-таблица не является табличным документов";
	КонецЕсли;
	
	УчитыватьТолькоВидимыеКолонки = Ложь;
	Если ТипЗнч(УчитыватьТолькоВидимыеКолонкиИлиДопСообщениеОшибки) = Тип("Булево") Тогда
		УчитыватьТолькоВидимыеКолонки = УчитыватьТолькоВидимыеКолонкиИлиДопСообщениеОшибки;
	ИначеЕсли ТипЗнч(УчитыватьТолькоВидимыеКолонкиИлиДопСообщениеОшибки) = Тип("Строка") Тогда
		ДопСообщениеОшибки = УчитыватьТолькоВидимыеКолонкиИлиДопСообщениеОшибки;
	КонецЕсли;
	УчитыватьТолькоВидимыеСтроки = Ложь;
	Если ТипЗнч(УчитыватьТолькоВидимыеСтрокиИлиДопСообщениеОшибки) = Тип("Булево") Тогда
		УчитыватьТолькоВидимыеСтроки = УчитыватьТолькоВидимыеСтрокиИлиДопСообщениеОшибки;
	ИначеЕсли ТипЗнч(УчитыватьТолькоВидимыеСтрокиИлиДопСообщениеОшибки) = Тип("Строка") Тогда
		ДопСообщениеОшибки = УчитыватьТолькоВидимыеСтрокиИлиДопСообщениеОшибки;
	КонецЕсли;
	
	Таб1 = ПолучитьТаблицуЗначенийИзТабличногоДокумента(ТабДок1, УчитыватьТолькоВидимыеКолонки, УчитыватьТолькоВидимыеСтроки);
	Таб2 = ПолучитьТаблицуЗначенийИзТабличногоДокумента(ТабДок2, УчитыватьТолькоВидимыеКолонки, УчитыватьТолькоВидимыеСтроки);
	
	ПроверитьРавенствоТаблиц(Таб1, Таб2, ДопСообщениеОшибки);
	
КонецПроцедуры

// портирован из Functest
Функция ПолучитьТаблицуЗначенийИзТабличногоДокумента(ТабличныйДокумент, УчитыватьТолькоВидимыеКолонки = Ложь, УчитыватьТолькоВидимыеСтроки = Ложь) Экспорт
	
	ТипТабличногоДокумента = ТипЗнч(ТабличныйДокумент);
	Если ТипТабличногоДокумента <> Тип("ТабличныйДокумент") И ТипТабличногоДокумента <> Тип("ПолеТабличногоДокумента") Тогда
		ВызватьИсключение "ПолучитьТаблицуЗначенийИзТабличногоДокумента: Требуется тип ТабличныйДокумент или ПолеТабличногоДокумента";
	КонецЕсли;
	
	НомерПоследнейКолонки = ТабличныйДокумент.ШиринаТаблицы;
	НомерПоследнейСтроки = ТабличныйДокумент.ВысотаТаблицы;
	
	НоваяТаблицаЗначений = Новый ТаблицаЗначений;
	Колонки = НоваяТаблицаЗначений.Колонки;
	ТипСтрока = Новый ОписаниеТипов("Строка");
	
	// TODO При определении видимости не учитывается наличие нескольких форматов строк, сейчас видимоcть колонки определяется по формату первой строки
	УчитываемыеКолонки = Новый Массив;
	Для НомерКолонки = 1 По НомерПоследнейКолонки Цикл
		ОбластьКолонки = ТабличныйДокумент.Область(0, НомерКолонки, 1, НомерКолонки);
		
		УчитыватьКолонку = Не УчитыватьТолькоВидимыеКолонки Или ОбластьКолонки.Видимость;
		Если УчитыватьКолонку Тогда
			УчитываемыеКолонки.Добавить(НомерКолонки);
			ШиринаКолонки = ОбластьКолонки.ШиринаКолонки;
			Если ШиринаКолонки <= 1 Тогда
				ШиринаКолонки = 1;
			КонецЕсли;
			ИмяКолонки = "К" + Формат(Колонки.Количество() + 1, "ЧН=; ЧГ=0");
			Колонки.Добавить(ИмяКолонки, ТипСтрока, ИмяКолонки, ШиринаКолонки);
		КонецЕсли;
	КонецЦикла;
	
	ГраницаКолонок = УчитываемыеКолонки.ВГраница();
	Для НомерСтроки = 1 По НомерПоследнейСтроки Цикл
		
		Если УчитыватьТолькоВидимыеСтроки И Не ТабличныйДокумент.Область(НомерСтроки,, НомерСтроки).Видимость Тогда
			Продолжить;
		КонецЕсли;
		
		НоваяСтрока = НоваяТаблицаЗначений.Добавить();
		
		Для Индекс = 0 По ГраницаКолонок Цикл
			НомерКолонки = УчитываемыеКолонки[Индекс];
			Область = ТабличныйДокумент.Область(НомерСтроки, НомерКолонки, НомерСтроки, НомерКолонки);
			НоваяСтрока[Индекс] = Область.Текст;
		КонецЦикла;
	КонецЦикла;
	
	Возврат НоваяТаблицаЗначений;
	
КонецФункции

// портирован из Functest
Функция СравнитьТаблицы(ТаблицаОжиданий, ТаблицаРезультатов, ТаблицаРазличий)
	
	Если ТаблицаОжиданий.Количество() <> ТаблицаРезультатов.Количество() Тогда
		Возврат РезультатыСравненияТаблиц.РазноеКоличествоСтрок;
	КонецЕсли;
	
	Если ТаблицаОжиданий.Количество() = 0 Тогда
		Возврат РезультатыСравненияТаблиц.ТаблицыСовпадают; //Пустые таблицы всегда одинаковы
	КонецЕсли;
	
	//Проверим структуру колонок
	
	//TODO При этом сравнении в структуре ТаблицаРезультатов может оказаться больше колонок, чем в ТаблицаОжиданий,
	// так что для абсолютного точного сравнения нужно добавить проверку совпадения количества колонок.
	ОжидаемыеКолонки = ТаблицаОжиданий.Колонки;
	КолонкиРезультата = ТаблицаРезультатов.Колонки;
	Для Каждого Колонка Из ОжидаемыеКолонки Цикл
		Если КолонкиРезультата.Найти(Колонка.Имя) = Неопределено Тогда
			Возврат РезультатыСравненияТаблиц.РазличаютсяКолонки;
		КонецЕсли;
	КонецЦикла;
	
	Возврат СравнитьЗначенияТаблиц(ТаблицаОжиданий, ТаблицаРезультатов, ТаблицаРазличий);
	
КонецФункции

// портирован из Functest
Функция СравнитьЗначенияТаблиц(ТаблицаОжиданий, ТаблицаРезультатов, Различия)
	
	Различия = Новый ТаблицаЗначений;
	Различия.Колонки.Очистить();
	Различия.Колонки.Добавить("Строка",Новый ОписаниеТипов("Число"));
	Различия.Колонки.Добавить("Колонка",Новый ОписаниеТипов("Строка"));
	Различия.Колонки.Добавить("Ожидание");
	Различия.Колонки.Добавить("Результат");
	
	РезультатСравнения = РезультатыСравненияТаблиц.ТаблицыСовпадают;
	
	Колонки = ТаблицаОжиданий.Колонки;
	ГраницаСтрок = ТаблицаОжиданий.Количество() - 1;
	Для Индекс = 0 По ГраницаСтрок Цикл
		
		ОжидаемаяСтрока = ТаблицаОжиданий[Индекс];
		СтрокаРезультата = ТаблицаРезультатов[Индекс];
		
		Для Каждого Колонка Из Колонки Цикл
			ИмяКолонки = Колонка.Имя;
			
			ОжидаемоеЗначение = ОжидаемаяСтрока[ИмяКолонки];
			ЗначениеРезультата = СтрокаРезультата[ИмяКолонки];
			Если ОжидаемоеЗначение = ЗначениеРезультата
			 Или (Не ЗначениеЗаполнено(ОжидаемоеЗначение) И Не ЗначениеЗаполнено(ЗначениеРезультата)) Тогда //Пустые значения разных типов 1С-м не считаются равными :(
				Продолжить;
			КонецЕсли;
			
			Различие = Различия.Добавить();
			Различие.Строка = Индекс + 1;
			Различие.Колонка = ИмяКолонки;
			Различие.Ожидание = ОжидаемоеЗначение;
			Различие.Результат = ЗначениеРезультата;
			РезультатСравнения = РезультатыСравненияТаблиц.НеСовпадаютЗначенияВЯчейкеТаблицы;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат РезультатСравнения;
	
КонецФункции

Процедура ВызватьОшибкуПроверки(СообщениеОшибки = "")
	
	Префикс = "["+ СтатусыРезультатаТестирования().ОшибкаПроверки + "]";
	ВызватьИсключение Префикс + " " + СообщениеОшибки;
	
КонецПроцедуры

Функция СтатусыРезультатаТестирования()
	СтатусыРезультатаТестирования = Новый Структура;
	СтатусыРезультатаТестирования.Вставить("ОшибкаПроверки", "Failed");
	СтатусыРезультатаТестирования.Вставить("НеизвестнаяОшибка", "Broken");
	СтатусыРезультатаТестирования.Вставить("ТестПропущен", "Pending");
	
	Возврат Новый ФиксированнаяСтруктура(СтатусыРезультатаТестирования);
КонецФункции

РезультатыСравненияТаблиц = Новый Структура;
РезультатыСравненияТаблиц.Вставить("ТаблицыСовпадают", 0);
РезультатыСравненияТаблиц.Вставить("НеСовпадаютЗначенияВЯчейкеТаблицы", 1);
РезультатыСравненияТаблиц.Вставить("РазноеКоличествоСтрок", 2);
РезультатыСравненияТаблиц.Вставить("РазличаютсяКолонки", 3);
РезультатыСравненияТаблиц = Новый ФиксированнаяСтруктура(РезультатыСравненияТаблиц);
