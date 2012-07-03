#pragma once

template <class T>
class NsSingleton
{
public:
	static T* Instance();

protected:
	NsSingleton(){}
	virtual ~NsSingleton(){}

	static T* m_pInstance;
};

template <class T>
T*  NsSingleton<T>::m_pInstance = 0;

template <class T>
T* NsSingleton<T>::Instance()
{
	if(!m_pInstance)
	{
		m_pInstance = new T;
	}

	return m_pInstance;
}