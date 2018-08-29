#pragma once

#include <string>	 

struct strview {
	template <class T>
	strview(const T& str)
		: buf(str.data())
		, len(str.size())
	{ }
	strview(const char* buf, size_t len)
		: buf(buf)
		, len(len)
	{ }
	bool empty() const { return buf == 0; }
	const char* data() const { return buf; }
	size_t size() const { return len; }
	const char* buf;
	size_t len;
};

struct wstrview {
	template <class T>
	wstrview(const T& str)
		: buf(str.data())
		, len(str.size())
	{ }
	wstrview(const wchar_t* buf, size_t len)
		: buf(buf)
		, len(len)
	{ }
	bool empty() const { return buf == 0; }
	const wchar_t* data() const { return buf; }
	size_t size() const { return len; }
	const wchar_t* buf;
	size_t len;
};

std::wstring u2w(const strview& str);
std::string  w2u(const wstrview& wstr);
std::wstring a2w(const strview& str);
std::string  w2a(const wstrview& str);
std::string  a2u(const strview& str);
std::string  u2a(const strview& str);
