<template>
    <div class="  w-full h-screen bg-gray-700 ">
        <nav class="  flex flex-row text-green-500 gap-4  border-y-4 border-green-500  bg-gray-800 ">
            <NuxtLink to="/" class=" flex items-center justify-center text-7xl hover:text-green-400">⌂</NuxtLink>
            <NuxtLink to="/finance/" class="flex items-center justify-center text-3xl hover:text-green-400">Finance</NuxtLink>
            <NuxtLink to="/about" class="  flex items-center justify-center text-3xl hover:text-green-400">About</NuxtLink>            
        </nav>
        
    
        <slot />
    </div>
</template>