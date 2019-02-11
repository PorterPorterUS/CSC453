#include <ruby.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h> 
#include "extconf.h"

static VALUE rb_mHello;
static VALUE rb_CFixedArray;

typedef struct c_array_t* array_info;

struct c_array_t {
    unsigned long capacity;
    VALUE *ptr;
};

void cArray_free(array_info array) {
    free(array);
}

VALUE cArray_alloc(VALUE self)  {
    array_info array = malloc(sizeof(struct c_array_t));
	
	array->ptr = NULL;
    
    return Data_Wrap_Struct(self, NULL, cArray_free, array);
}

VALUE cArray_m_initialize(int argc, VALUE* argv, VALUE self) {
	
    array_info array;

    // unwrap
    Data_Get_Struct(self, struct c_array_t, array);

    VALUE man, opt;

    rb_scan_args(argc, argv, "11", &man, &opt);

    unsigned long cap = NUM2ULONG(man);
    array->capacity = cap;
	array->ptr = malloc(sizeof(VALUE*) * array->capacity);
    
    if (argc == 1) {    
		for (unsigned long i = 0; i < array->capacity; i++) {
			array->ptr[i] = Qnil;
		}
        printf("Create a new C implemented array with capacity of %lu and initialize to nil by default\n", array->capacity);
    } else {
		for (unsigned long i = 0; i < array->capacity; i++) {
			array->ptr[i] = (VALUE*) malloc(sizeof(VALUE));
			array->ptr[i] = opt;
		}
		switch (TYPE(opt)) {
				case T_NIL:
					printf("Create a new C implemented array with capacity of %lu and initialize to nil\n", array->capacity);
					break;
				case T_FIXNUM:
					printf("Create a new C implemented array with capacity of %lu and initialize to %ld\n", array->capacity, NUM2LONG(opt));
					break;
				case T_FLOAT:
					printf("Create a new C implemented array with capacity of %lu and initialize to %f\n", array->capacity, NUM2DBL(opt));
					break;
				case T_STRING:
					printf("Create a new C implemented array with capacity of %lu and initialize to %s\n", array->capacity, StringValueCStr(opt));
					break;
				default:
					break;
			}
    }
	
    return self;
}

VALUE cArray_m_each(VALUE self) {
	
	array_info array;
	
	 // unwrap
    Data_Get_Struct(self, struct c_array_t, array);
	
	for (unsigned long i = 0; i < array->capacity; i++) {
		rb_yield(array->ptr[i]);
	}
	
	return self;
}

VALUE cArray_m_insert(int argc, VALUE* argv, VALUE self) {
	
	array_info array;
	
	// unwrap
	Data_Get_Struct(self, struct c_array_t, array);
	
	VALUE position, value;
	
	 rb_scan_args(argc, argv, "11", &position, &value);
	 
	 if (argc != 2) {
		 rb_raise(rb_eRuntimeError, "Wrong number of arguments");
	 }
	 
	 unsigned long pos = NUM2ULONG(position);
	
	if (pos < 0 || pos >= array->capacity) {
		rb_raise(rb_eRuntimeError, "Error insert position");
	} else {
		array->ptr[pos] = value;

		switch (TYPE(value)) {
				case T_NIL:
					printf("Insert nil at %lu position in C implemented array\n", pos);
					break;
				case T_FIXNUM:
					printf("Insert %ld at %lu position in C implemented array\n", NUM2LONG(value), pos);
					break;
				case T_FLOAT:
					printf("Insert %f at %lu position in C implemented array\n", NUM2DBL(value), pos);
					break;
				case T_STRING:
					printf("Insert %s at %lu position in C implemented array\n", StringValueCStr(value), pos);
					break;
				default:
					break;
			}
	}
	
	return self;
}

VALUE cArray_m_sum(VALUE self) {
	
	array_info array;
	
	// unwrap
	Data_Get_Struct(self, struct c_array_t, array);
	
	long lsum = 0;
	double dsum = 0;
	
	bool dbl_flag = false;
	
	for (unsigned long i = 0; i < array->capacity; i++) {
		switch (TYPE(array->ptr[i])) {
				case T_NIL:
					rb_raise(rb_eRuntimeError, "Error type for sum");
					return;
				case T_FIXNUM:
					lsum += NUM2LONG(array->ptr[i]);
					break;
				case T_FLOAT:
					if (!dbl_flag) {
						dsum = lsum;
						dbl_flag = true;
					}
					if (dbl_flag) {
						dsum += NUM2DBL(array->ptr[i]);
					}
					break;
				case T_STRING:
					rb_raise(rb_eRuntimeError, "Error type for sum");
					return;
				default:
					break;
			}
	}
	
	if (dbl_flag) {
		return DBL2NUM(dsum);
	} else {
		return LONG2NUM(lsum);
	}
}

/* IMPORTANT MAKE YOUR NAME AS 'Init_(klass)' */ 
void Init_CFixedArray(VALUE self, VALUE cap, VALUE val) {
    // define the module name;
    rb_mHello = rb_define_module("Hello");

    // define the "CFixedArray" class under the "Hello" module; 
    rb_CFixedArray = rb_define_class_under(rb_mHello, "CFixedArray", rb_cObject);
	
    // this is important to tell Ruby any data structure needed to alloc.
    rb_define_alloc_func(rb_CFixedArray, cArray_alloc);

    // define each individual methods in the class;
    rb_define_method(rb_CFixedArray, "initialize", cArray_m_initialize, -1);
	rb_define_method(rb_CFixedArray, "each", cArray_m_each, 0);
	rb_define_method(rb_CFixedArray, "insert", cArray_m_insert, -1);
	rb_define_method(rb_CFixedArray, "sum", cArray_m_sum, 0);
}