## Задание 8

1. Напишите оператор, добавляющий пометку “(s)” в начало комментария по каждому заказу, исполнитель которого – студент. Выполните этот оператор.

Замечание: Если при соединении строк один из операндов имеет значение NULL, результатом операции сложения в “правильных” СУБД будет NULL. В нашем случае может выручить, например, использование стандартной функции конкатенации.

1. Напишите оператор, удаляющий все заказы по combing-у, которые еще не выполнены (“Мы приостанавливаем оказание этой услугу из-за отсутствия лицензии”).
2. Напишите оператор, добавляющий в таблицу PERSON новое физическое лицо с сохранением последовательной нумерации записей (используйте вложенный select с “max(…) + 1”).

Добавьте одну новую запись (например, себя).

Создайте в базе новую таблицу для хранения данных о документах физ.лиц (вид и номер документа). При создании связи от нее к таблице PERSON укажите свойства каскадности редактирования и удаления.

Добавьте в нее пару документов для только что созданного нового физ.лица.

Убедитесь, что каскад работает:

- Измените Person_ID последнего созданного физ.лица и проверьте, остались ли его документы за ним.

- Удалите это физ.лицо и посмотрите, удалились ли автоматически все его документы.

Замечание: Подумайте, каким еще ключам следовало бы добавить каскадные свойства, чтобы модель сохранила работоспособность. Ведь если этого не сделать, попытка удаления любой персоны, зарегистрированной уже как сотрудник или владелец, приведет к ошибке.

Продемонстрируйте преподавателю выполнение всех запросов.