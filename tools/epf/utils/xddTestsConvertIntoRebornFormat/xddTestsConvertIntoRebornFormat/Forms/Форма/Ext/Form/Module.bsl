﻿
Процедура ПриОткрытии()
	ИскатьВПодкаталогах = Истина;
КонецПроцедуры

Процедура КнопкаКонвертироватьНажатие(Кнопка)
	Инициализация();
	ВключитьЛог(ПодробныйЛог);
	
	Если ЭлементыФормы.Панель1.ТекущаяСтраница = ЭлементыФормы.Панель1.Страницы.Каталог Тогда
		РезультатыПреобразования = ПреобразоватьКаталог(Каталог, ИскатьВПодкаталогах);
	Иначе
		НаборФайлов = Новый Массив;
		Для к = 1 По СтрЧислоСтрок(Файлы) Цикл
			НаборФайлов.Добавить(Новый Файл(СтрПолучитьСтроку(Файлы, 1)));
		КонецЦикла;
		РезультатыПреобразования = ПреобразоватьФайлы(НаборФайлов);
	КонецЕсли;
	ПоказатьСтатистику(РезультатыПреобразования);
КонецПроцедуры

Процедура ПоказатьСтатистику(РезультатыПреобразования)
	Сообщить("Найдено внешних обработок - "+РезультатыПреобразования.НайденоВнешнихОбработок+" шт.");
	Сообщить("Найдено файлов-тестов в старом формате - "+РезультатыПреобразования.НайденоФайловТестов+" шт.");
	Сообщить("Конвертировано в новый формат тестов - "+РезультатыПреобразования.КонвертированоТестов+" шт.");
КонецПроцедуры

Процедура КаталогНачалоВыбора(Элемент, СтандартнаяОбработка)
	НовыйКаталог = ВыбратьПутьИнтерактивно(Каталог);
	Если Не ПустаяСтрока(НовыйКаталог) Тогда
		Каталог = НовыйКаталог;
	КонецЕсли;
КонецПроцедуры

Функция ВыбратьПутьИнтерактивно(ТекущийПуть = "") Экспорт
	ДиалогВыбораКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбораКаталога.Каталог = ТекущийПуть;
	
	Результат = "";
	Если ДиалогВыбораКаталога.Выбрать() Тогда
		Результат = ДиалогВыбораКаталога.Каталог;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

Процедура ФайлыНачалоВыбора(Элемент, СтандартнаяОбработка)
	ПервыйФайл = ?(ЗначениеЗаполнено(Файлы), СтрПолучитьСтроку(Файлы, 1), "");
	НовыеФайлы = ВыбратьФайлыИнтерактивно(ПервыйФайл);
	Если Не ПустаяСтрока(НовыеФайлы) Тогда
		Файлы = НовыеФайлы;
	КонецЕсли;
КонецПроцедуры

Функция ВыбратьФайлыИнтерактивно(ТекущийПуть = "") Экспорт
	ДиалогВыбораТеста = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбораТеста.Фильтр = "Обработка-тест (*.epf)|*.epf|Все файлы|*";
	ДиалогВыбораТеста.МножественныйВыбор = Истина;
	ДиалогВыбораТеста.ПроверятьСуществованиеФайла = Истина;
	ДиалогВыбораТеста.ПолноеИмяФайла = ТекущийПуть;
	
	Результат = Новый ТекстовыйДокумент;
	Если ДиалогВыбораТеста.Выбрать() Тогда
		Для каждого ПолноеИмяФайла Из ДиалогВыбораТеста.ВыбранныеФайлы Цикл
			Результат.ДобавитьСтроку(ПолноеИмяФайла);
		КонецЦикла;
	КонецЕсли;
	Текст = Результат.ПолучитьТекст();
	
	Возврат Лев(Текст, СтрДлина(Текст) - 1);
КонецФункции
