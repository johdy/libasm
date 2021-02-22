#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/errno.h>

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

int	ft_atoi_base(char *s1, char *s2);
void	ft_list_push_front(t_list **alst, void *new);
int		ft_list_size(t_list *lst);
void ft_list_sort(t_list **begin_list, int (*cmp)());
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
char *ft_strdup(const char *s1);
int		ft_strcmp(const char *s1, const char *s2);

void display_list(t_list *elem)
{
	int i;

	i = 0;
	while(elem)
	{
		i++;
		printf("elem %d : %s // %p\n", i, elem->data, elem);
		elem = elem->next;
	}
}

void free_function(void *ptr)
{
	free(ptr);
}

void test_atoi_base(void)
{
	printf("//////////TESTS ATOI_BASE//////////\n");
	printf("nombre: '%s', base: '%s' ==> %d\n", "1101011001", "01", ft_atoi_base("1101011001","01"));
	printf("nombre: '%s', base: '%s' ==> %d\n", " 755x+", "01234567", ft_atoi_base(" 755x+","01234567"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "42", "0123456789", ft_atoi_base("42","0123456789"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "bonjours", "bonjurs", ft_atoi_base("bonjours","bonjurs"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "bonjours", "bonjours", ft_atoi_base("bonjours","bonjours"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "cb  a", " abc", ft_atoi_base("cb  a"," abc"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "cb  a", "abc", ft_atoi_base("cb  a","abc"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "-cb  a", "abc", ft_atoi_base("-cb  a","abc"));	
	printf("nombre: '%s', base: '%s' ==> %d\n", "---cb  a", "abc", ft_atoi_base("---cb  a","abc"));	
	printf("nombre: '%s', base: '%s' ==> %d\n", "+++cb  a", "abc", ft_atoi_base("+++cb  a","abc"));	
	printf("nombre: '%s', base: '%s' ==> %d\n", "-+cb  a", "abc", ft_atoi_base("-+cb  a","abc"));	
	printf("nombre: '%s', base: '%s' ==> %d\n", "- cb  a", "abc", ft_atoi_base("- cb  a","abc"));	
	printf("nombre: '%s', base: '%s' ==> %d\n", "   -cb  a", "abc", ft_atoi_base("   -cb  a","abc"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "   +++cb  a", "abc", ft_atoi_base("   +++cb  a","abc"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "   +cb  a", "abc", ft_atoi_base("   +cb  a","abc"));	
	printf("nombre: '%s', base: '%s' ==> %d\n", "2147483647", "0123456789", ft_atoi_base("2147483647","0123456789"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "-2147483648", "0123456789", ft_atoi_base("-2147483648","0123456789"));
	printf("nombre: '%s', base: '%s' ==> %d\n", "2147483648", "0123456789", ft_atoi_base("2147483648","0123456789"));

}

t_list *init_list(void)
{
	t_list	*list;
	t_list	*list_next;
	t_list	*list_last;
	t_list	*ret;

	list = malloc(sizeof(t_list));
	list_next = malloc(sizeof(t_list));
	list_last = malloc(sizeof(t_list));
	list->data = ft_strdup("carton");
	list->next = list_next;
	list_next->data = ft_strdup("scred");
	list_next->next = list_last;
	list_last->data = ft_strdup("jamy");
	list_last->next = NULL;
	ret = list;
	display_list(ret);
	return (ret);
}

int main(void)
{
	t_list *list;
	t_list *new_list;
	char *str;

	test_atoi_base();
	list = malloc(sizeof(t_list));
	list = NULL;
	printf("//////////TEST LIST_SIZE_VIDE//////////\n");
	printf("list size : %d\n", ft_list_size(list));
	printf("//////////TEST LSTPUSHFRONT SUR LISTE VIDE//////////\n");
	ft_list_push_front(&list, ft_strdup("Shawn Jay-Z Carter is pleased to announce a partnership with Moët Hennessy, the world leader in luxury wines and spirits"));
	display_list(list);
	printf("//////////TEST LSTREMOVEIF POUR NOUVELLE LISTE//////////\n");
	ft_list_remove_if(&list, "owww", &ft_strcmp, &free_function);
	list = init_list();
	display_list(list);
	printf("//////////TEST LSTPUSHFRONT SUR LISTE//////////\n");
	ft_list_push_front(&list, ft_strdup("owww"));
	ft_list_push_front(&list, ft_strdup("carton"));
	ft_list_push_front(&list, ft_strdup("owwww"));
	display_list(list);
	printf("list size : %d\n", ft_list_size(list));
	printf("//////////TEST LSTSORT//////////\n");
	ft_list_sort(&list, &ft_strcmp);
	display_list(list);
	printf("//////////TEST LSTREMOVEIF toto//////////\n");
	ft_list_remove_if(&list, "toto", &ft_strcmp, &free_function);
	display_list(list);
	printf("//////////TEST LSTREMOVEIF owww//////////\n");
	ft_list_remove_if(&list, "owww", &ft_strcmp, &free_function);
	display_list(list);
	printf("//////////TEST LSTREMOVEIF carton//////////\n");
	ft_list_remove_if(&list, "carton", &ft_strcmp, &free_function);
	display_list(list);
	printf("//////////NOUVELLE LISTE//////////\n");
	new_list = malloc(sizeof(t_list));
	ft_list_push_front(&new_list, ft_strdup("zzzzz"));
	ft_list_push_front(&new_list, ft_strdup("quignon"));
	ft_list_push_front(&new_list, ft_strdup("pour une fois"));
	ft_list_push_front(&new_list, ft_strdup("zippy"));
	ft_list_push_front(&new_list, ft_strdup("comman"));
	ft_list_push_front(&new_list, ft_strdup("yes"));
	ft_list_push_front(&new_list, ft_strdup("who are you"));
	display_list(new_list);
	printf("//////////NOUVEAU SORT//////////\n");
	ft_list_sort(&new_list, &ft_strcmp);
	display_list(new_list);
}
